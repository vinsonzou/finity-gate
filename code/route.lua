return
{
  ['/user/signup'] = require('user.signup'),
  ['/user/signin'] = require('user.signin'),
  ['/user/refresh'] = require('user.refresh'),
  ['/user/verify'] = require('user.verify'),

  ['/server/list'] = require('server.list'),

  ['/pay/create'] = require('pay.create'),
  ['/pay/notify'] = require('pay.notify'),
}
