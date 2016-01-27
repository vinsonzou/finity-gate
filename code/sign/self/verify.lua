local throw = require('throw')
local const = require('const')

-- INTERNAL CALL
return function(sid, red)
  local sidkey = const.KEY_SID .. sid
  local id, err = red:get(sidkey)
  if not id then
    ngx.log(ngx.ERR, 'failed to call redis get: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  if id == ngx.null then
    throw(ngx.HTTP_UNAUTHORIZED)
  end
  local sidexpire = red:ttl(sidkey)
  if not sidexpire then
    ngx.log(ngx.ERR, 'failed to call redis ttl: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  local userkey = const.KEY_USER .. id
  local user, err = red:hmget(userkey)
  if not user then
    ngx.log(ngx.ERR, 'failed to call redis hmget: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  local tokenkey = const.KEY_TOKEN .. user.token
  local tokenexpire = red:ttl(tokenkey)
  if not tokenexpire then
    ngx.log(ngx.ERR, 'failed to call redis ttl: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end

  return
  {
    id = tonumber(id),
    token = {value = user.token, expire = tokenexpire},
    sid = {value = sid, expire = sidexpire},
  }
end