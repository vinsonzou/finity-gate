-- FOR CLIENT
return function(args, data, red)
  local gameid = args.id

  local sql = 'SELECT version, url FROM resource WHERE gameid = %d ORDER BY version DESC'
  local rs = data.query(sql, gameid)

  return
  {
    resources = rs
  }
end