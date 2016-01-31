local const = require('const')
local throw = require('throw')

-- INTERNAL CALL
-- TODO bug: old token and sid still valid
return function(id, red)
  local now = ngx.now()
  local token, sid = 'self@' .. ngx.md5(id .. now .. const.SECRET_TOKEN), 'self@' .. ngx.md5(id .. now .. const.SECRET_SID)
  local tokenkey, sidkey, userkey = const.KEY_TOKEN .. token, const.KEY_SID .. sid, const.KEY_USER .. id

  red:watch(tokenkey, sidkey, userkey)
  local ok, err = red:multi()
  if not ok then
    ngx.log(ngx.ERR, 'failed to call redis multi: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  local ok, err = red:setex(tokenkey, const.EXPIRE_TOKEN, id)
  if not ok then
    ngx.log(ngx.ERR, 'failed to call redis setex: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  local ok, err = red:setex(sidkey, const.EXPIRE_SID, id)
  if not ok then
    ngx.log(ngx.ERR, 'failed to call redis setex: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  local ok, err = red:hmset(userkey, 'token', token, 'sid', sid)
  if not ok then
    ngx.log(ngx.ERR, 'failed to call hmset: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  local ok, err = red:exec()
  if not ok then
    ngx.log(ngx.ERR, 'failed to call redis exec: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  if ok == ngx.null then
    ngx.log(ngx.ERR, 'redis concurrent access')
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end

  return
  {
    token = {value = token, expire = const.EXPIRE_TOKEN},
    sid = {value = sid, expire = const.EXPIRE_SID}
  }
end
