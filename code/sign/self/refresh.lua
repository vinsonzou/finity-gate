local throw = require('throw')
local const = require('const')
local token = require('sign.self.token')

return function(tk, red)
  local tokenkey = const.KEY_TOKEN .. tk
  local id, err = red:get(tokenkey)
  if not id then
    ngx.log(ngx.ERR, 'failed to call redis get: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  if id == ngx.null then
    throw(ngx.HTTP_UNAUTHORIZED)
  end
  return token(id, red)
end
