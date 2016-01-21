local const = require('const')
local throw = require('throw')

return function(id, red)
  local now = ngx.now()
  local token, sid = ngx.md5(id .. now .. const.SECRET_TOKEN), ngx.md5(id .. now .. const.SECRET_SID)
  local tokenkey, sidkey = const.KEY_TOKEN .. token, const.KEY_SID .. sid

  red:watch(tokenkey, sidkey)
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