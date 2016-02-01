local cjson = require('cjson')
local mysql = require('resty.mysql')
local redis = require('resty.redis')

local config = require('config')
local data = require('data')
local route = require('route')

local function before()
  local my, err = mysql:new()
  if not my then
    ngx.log(ngx.ERR, 'failed to new mysql: ', err)
    return
  end
  my:set_timeout(config.mysql.timeout)
  local ret, err, errno, sqlstate = my:connect(config.mysql.datasource)
  if not ret then
    ngx.log(ngx.ERR, 'failed to connect to mysql: ', err)
    return
  end
  local ret, err, errno, sqlstate = my:query('START TRANSACTION')
  if not ret then
    my:close()
    ngx.log(ngx.ERR, 'failed to start mysql transaction: ', err)
    return
  end

  local red, err = redis:new()
  if not red then
    ngx.log(ngx.ERR, 'failed to new redis: ', err)
    my:close()
    return
  end
  red:set_timeout(config.redis.timeout)
  local ok, err = red:connect(config.redis.host)
  if not ok then
    ngx.log(ngx.ERR, 'failed to connect to redis: ', err)
    red:close()
    my:close()
    return
  end
  return my, red
end

local function after(my, red, commit)
  if my then
    if commit then
      my:query('COMMIT')
    else
      my:query('ROLLBACK')
    end
    my:set_keepalive(config.mysql.keepalive, config.mysql.poolsize)
  end
  if red then
    red:set_keepalive(config.redis.keepalive, config.redis.poolsize)
  end
end

return function()
  local action = route[ngx.var.uri]
  if not action then
    ngx.log(ngx.ERR, 'failed to access uri: ', ngx.var.uri)
    ngx.exit(ngx.HTTP_NOT_FOUND)
  end
  local method, args, err = ngx.req.get_method()
  if method == 'GET' then
    args = ngx.req.get_uri_args()
  elseif method == 'POST' then
    ngx.req.read_body()
    args, err = ngx.req.get_post_args()
    if not args then
      ngx.say('failed to read post args: ', err)
      ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
    end
  else
    ngx.exit(ngx.HTTP_METHOD_NOT_IMPLEMENTED)
  end

  local my, red = before()
  if not my then
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end

  local commit, resp = pcall(function()
    return action(args, data(my), red)
  end)
  after(my, red, commit)

  if not commit then
    ngx.log(ngx.ERR, resp)
    local idx = string.find(resp, '{', 1, true)
    if idx then
      resp = loadstring('return ' .. string.sub(resp, idx))()
    else
      resp = { err = ngx.HTTP_INTERNAL_SERVER_ERROR }
    end
    ngx.log(ngx.ERR, 'failed to call action: ', ngx.var.uri, ', errcode: ', resp.err)
    ngx.exit(resp.err)
  end

  local o = resp and cjson.encode(resp) or '{}'
  ngx.say(args.callback and args.callback .. '(' .. o .. ');' or o)
end