return
{
  debug = true,

  -- mysql config
  mysql =
  {
    timeout = 1000,
    keepalive = 6000,
    poolsize = 64,
    datasource =
    {
      host = '127.0.0.1',
      port = 3306,
      database = 'gate',
      user = 'finity',
      password = 'finity'
    }
  },

  -- redis config
  redis =
  {
    timeout = 1000,
    keepalive = 6000,
    poolsize = 64,
    host = 'unix:/usr/local/var/run/redis-finity-gate.sock'
  }
}

