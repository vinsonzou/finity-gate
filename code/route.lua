return
{
  ['/c/game/update'] = require('game.update'),
  ['/c/server/list'] = require('server.list'),

  ['/c/sign/signup'] = require('sign.signup'),
  ['/c/sign/signin'] = require('sign.signin'),
  ['/s/sign/refresh'] = require('sign.verify'),
  ['/s/sign/verify'] = require('sign.refresh'),

  ['/c/pay/create'] = require('pay.create'),
  ['/p/pay/notify/alipay'] = require('pay.alipay.notify'),
  ['/p/pay/notify/yeepay'] = require('pay.yeepay.notify')
}
