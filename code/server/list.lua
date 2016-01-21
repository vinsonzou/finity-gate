local const = require('const')
local throw = require('throw')

return function(args, data, red)
  local gameid, sid = args.gameid, args.sid

  local id, err = red:get(const.KEY_SID .. sid)
  if not id then
    ngx.log(ngx.ERR, 'failed to call redis get: ', err)
    throw(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  if id == ngx.null then
    throw(ngx.HTTP_UNAUTHORIZED)
  end
  id = tonumber(id)

  local sql =
  [[
    SELECT s.id, s.name, s.host, s.port, (CASE WHEN p.playerid IS NULL THEN 0 ELSE 1 END) AS n
    FROM server AS s LEFT JOIN player AS p ON s.id = p.serverid AND p.userid = %d
    WHERE s.gameid = %d
  ]]
  local servers = data.query(sql, id, gameid)

  return
  {
    servers = servers
  }
end