local throw = require('throw')

local platforms =
{
  self = require('sign.self.refresh'),
  safe = require('sign.safe.refresh'),
  uc = require('sign.uc.refresh'),
}

-- FOR GAME SERVER
return function(args, data, red)
  local token = args.token
  if not token then
    throw(ngx.HTTP_ILLEGAL)
  end
  local idx = string.find(token, '@', 1, true)
  if not idx then
    throw(ngx.HTTP_ILLEGAL)
  end
  local platform = loadstring('return ' .. string.sub(token, 1, idx))()
  if not platforms[platform] then
    throw(ngx.HTTP_ILLEGAL)
  end
  local ret = platforms[platform](token, red)
  if not ret then
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end

  --TODO 3rd-party id <-> user id mapping

  return
  {
    userid = ret.id,
    token = ret.token,
    sid = ret.sid
  }
end