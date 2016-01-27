local quote = ngx.quote_sql_str
local throw = require('throw')
local token = require('sign.self.token')

-- FOR CLIENT
return function(args, data, red)
  local name, pass = args.name, args.pass

  local sql = 'SELECT * FROM user WHERE name = %s'
  local user = data.queryone(sql, quote(name))
  if user then
    throw(ngx.HTTP_CONFLICT)
  end

  local md5 = ngx.md5(pass)
  sql = 'INSERT INTO user(name, pass, platform) VALUES(%s, %s, %s)'
  local id = data.insert(sql, quote(name), quote(md5), quote('self'))
  local ret = token(id, red)
  return
  {
    sid = ret.sid
  }
end