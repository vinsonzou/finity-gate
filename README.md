# finity-gate
<pre>
A user system and charge gate of finity games.
GET/POST supported.
JSON/JSONP supported.
</pre>

## 1. Interfaces for client

### game update
<pre>
<b>URI</b>:
/c/game/update
<b>REQ</b>:
id: integer, game id
<b>RES</b>:
resources: array, game resource list
&nbsp;&nbsp;version: string, resource version
&nbsp;&nbsp;url: string, resource url for downloading
</pre>

### server list
<pre>
<b>URI</b>:
/c/server/list
<b>REQ</b>:
gameid: integer, game id
sid: string, user session id
<b>RES</b>:
servers: array, game server list
&nbsp;&nbsp;id: integer, server id
&nbsp;&nbsp;name: string, server name
&nbsp;&nbsp;host: string, server host, e.g: s1.weiyouba.cn
&nbsp;&nbsp;port: integer, server port
&nbsp;&nbsp;n: integer, role number in this server, 0/1
</pre>

### signup
<pre>
<b>URI</b>:
/c/sign/signup
<b>REQ</b>:
name: string, user name
pass: string, user password
<b>RES</b>:
sid: string, user session id
</pre>

### signin
<pre>
<b>URI</b>:
/c/sign/signin
<b>REQ</b>:
name: string, user name
pass: string, user password
<b>RES</b>:
sid: string, user session id
</pre>

### create order
<pre>
<b>URI</b>:
/c/pay/create
<b>REQ</b>:
serverid: integer, game server id
fee: integer, pay cents
extra: string, extra info of the order, may be omitted
platform: string, 3rd-party platform(alipay, yeepay, etc.)
<b>RES</b>:
id: integer, order id
</pre>

## 2. Interfaces for game server

### verify
<pre>
<b>URI</b>:
/s/sign/verify
<b>REQ</b>:
sid: string, user session id
<b>RES</b>:
userid: integer, user id
token: object, refresh token
&nbsp;&nbsp;value: string, refresh token value
&nbsp;&nbsp;expire: integer, expire seconds
sid: object, user session id
&nbsp;&nbsp;value: string, session id value
&nbsp;&nbsp;expire: integer, expire seconds
</pre>

### refresh
<pre>
<b>URI</b>:
/s/sign/refresh
<b>REQ</b>:
token: string, refresh token
<b>RES</b>:
userid: integer, user id
token: object, refresh token
&nbsp;&nbsp;value: string, refresh token value
&nbsp;&nbsp;expire: integer, expire seconds
sid: object, user session id
&nbsp;&nbsp;value: string, session id value
&nbsp;&nbsp;expire: integer, expire seconds
</pre>

## 3. platform notification of payment
TODO:
/p/pay/notify/alipay
/p/pay/notify/yeepay