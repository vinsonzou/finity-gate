local quote = ngx.quote_sql_str
local verify = require('user.verify')

return function(args, data, red)
  local serverid, fee, extra = args.serverid, args.fee, args.extra
  local userid = verify(args, data, red).id

  local now = ngx.time()
  if extra then
    extra = quote(extra)
  else
    extra = 'NULL'
  end

  local sql = 'INSERT INTO pay(userid, serverid, fee, createtime, extra) VALUES(%d, %d, %d, %d, %s)'
  data.update(sql, userid, serverid, fee, now, extra)
end