local throw = require('throw')

local platforms =
{
  self = require('sign.self.verify'),
  safe = require('sign.safe.verify'),
  uc = require('sign.uc.verify'),
}

-- FOR GAME SERVER
return function(args, data, red)
  local sid = args.sid
  if not sid then
    throw(ngx.HTTP_ILLEGAL)
  end
  local idx = string.find(sid, '@', 1, true)
  if not idx then
    throw(ngx.HTTP_ILLEGAL)
  end
  local platform = loadstring('return ' .. string.sub(sid, 1, idx))()
  if not platforms[platform] then
    throw(ngx.HTTP_ILLEGAL)
  end
  local ret = platforms[platform](sid, red)
  if not ret then
    throw(ngx.HTTP_UNAUTHORIZED)
  end

  --TODO 3rd-party id <-> user id mapping

  return
  {
    userid = ret.id,
    token = ret.token,
    sid = ret.sid
  }
end