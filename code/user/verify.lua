local throw = require('throw')
local const = require('const')

return function(args, data, red)
  local sid = args.sid

  local id, err = red:get(const.KEY_SID .. sid)
  if not id then
    ngx.log(ngx.ERR, 'failed to call redis get: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  if id == ngx.null then
    throw(ngx.HTTP_UNAUTHORIZED)
  end

  return
  {
    id = tonumber(id)
  }
end