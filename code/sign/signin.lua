local quote = ngx.quote_sql_str
local throw = require('throw')
local token = require('sign.self.token')

-- FOR CLIENT
return function(args, data, red)
  local name, pass = args.sid, args.name, args.pass

  local md5 = ngx.md5(pass)
  local sql = 'SELECT id FROM user WHERE name = %s AND pass = %s'
  local user = data.queryone(sql, quote(name), quote(md5))
  if not user then
    throw(ngx.HTTP_UNAUTHORIZED)
  end
  local ret = token(user.id, red)
  return
  {
    sid = ret.sid
  }
end