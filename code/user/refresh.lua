local throw = require('throw')
local const = require('const')

return function(args, data, red)
  local token = args.token

  local id, err = red:get(const.KEY_TOKEN .. token)
  if not id then
    ngx.log(ngx.ERR, 'failed to call redis get: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  if id == ngx.null then
    throw(ngx.HTTP_UNAUTHORIZED)
  end

  local now = ngx.now()
  local sid = ngx.md5(id .. now .. const.SECRET_SID)
  local sidkey = const.KEY_SID .. sid
  local ok, err = red:setex(sidkey, const.EXPIRE_SID, id)
  if not ok then
    ngx.log(ngx.ERR, 'failed to call redis setex: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end

  return
  {
    sid = {value = sid, expire = const.EXPIRE_SID}
  }
end
