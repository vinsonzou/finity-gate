local quote = ngx.quote_sql_str
local throw = require('throw')
local verify = require('user.verify')

local platforms =
{
  alipay = require('pay.alipay.create'),
  yeepay = require('pay.yeepay.create'),
}

-- FOR CLIENT
return function(args, data, red)
  local serverid, fee, extra, platform = args.serverid, args.fee, args.extra, args.platform

  if not platform or not platforms[platform] then
    throw(ngx.HTTP_ILLEGAL)
  end
  local userid = verify(args, data, red).id

  local now = ngx.time()
  if extra then
    extra = quote(extra)
  else
    extra = 'NULL'
  end

  local sql = 'INSERT INTO pay(userid, serverid, fee, createtime, extra, platform, orderid) VALUES(%d, %d, %d, %d, %s, %s, %s)'
  local id = data.insert(sql, userid, serverid, fee, now, extra, quote(platform), quote(''))

  args.payid = id
  local orderid = platforms[platform](args)

  local sql = 'UPDATE pay SET orderid = %s WHERE id = %d AND orderid = %s'
  local rown = data.update(sql, quote(orderid), id, quote(''))
  if rown ~= 1 then
    throw(ngx.HTTP_SERVICE_UNAVAILABLE)
  end

  return
  {
    id = id
  }
end

