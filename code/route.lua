return
{
  ['/gate/user/signup'] = require('user.signup'),
  ['/gate/user/signin'] = require('user.signin'),
  ['/gate/user/refresh'] = require('user.refresh'),
  ['/gate/user/verify'] = require('user.verify'),

  ['/gate/server/list'] = require('server.list'),
}
