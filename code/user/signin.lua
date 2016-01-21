local quote = ngx.quote_sql_str
local throw = require('throw')
local _token = require('user._token')

return function(args, data, red)
  local name, pass = args.name, args.pass
  local md5 = ngx.md5(pass)

  local sql = 'SELECT id FROM user WHERE name = %s AND pass = %s'
  local user = data.queryone(sql, quote(name), quote(md5))
  if not user then
    throw(ngx.HTTP_UNAUTHORIZED)
  end
  return _token(user.id, red)
end