# 摘要
<pre>
游戏用户系统及充值网关
支持HTTP GET/POST请求
JSON/JSONP数据格式
</pre>

## 一. 客户端相关接口

### 游戏包更新检测
<pre>
<b>URI</b>:
/c/game/update
<b>REQ</b>:
id: 整型, 游戏ID
<b>RES</b>:
resources: 数组, 游戏资源列表
&nbsp;&nbsp;version: 字符, 版本号
&nbsp;&nbsp;url: 字符, 资源下载链接
</pre>

### 分服列表
<pre>
<b>URI</b>:
/c/server/list
<b>REQ</b>:
gameid: 整型, 游戏ID
sid: 字符, 会话凭证
<b>RES</b>:
servers: 数组, 分服列表
&nbsp;&nbsp;id: 整型, 分服ID
&nbsp;&nbsp;name: 字符, 分服名称
&nbsp;&nbsp;host: 字符, 分服地址
&nbsp;&nbsp;port: 整型, 分服端口
&nbsp;&nbsp;n: 整型, 分服中拥有的角色数量
</pre>

### 注册
<pre>
<b>URI</b>:
/c/sign/signup
<b>REQ</b>:
name: 字符, 用户名
pass: 字符, 密码
<b>RES</b>:
sid: 字符, 会话凭证
</pre>

### 登录
<pre>
<b>URI</b>:
/c/sign/signin
<b>REQ</b>:
name: 字符, 用户名
pass: 字符, 密码
<b>RES</b>:
sid: 字符, 会话凭证
</pre>

### 创建充值订单
<pre>
<b>URI</b>:
/c/pay/create
<b>REQ</b>:
serverid: 整型, 订单所有分服ID
fee: 整型, 充值金额(分)
extra: 字符, 订单额外信息
platform: 字符, 三方支付平台名称
<b>RES</b>:
id: 整型, 订单ID
</pre>

## 二. 分服调用的相关接口

### 会话凭证校验
<pre>
<b>URI</b>:
/s/sign/verify
<b>REQ</b>:
sid: 字符, 会话凭证
<b>RES</b>:
userid: 整型, 用户ID
token: 对象, 刷新令牌信息
&nbsp;&nbsp;value: 字符, 刷新令牌值
&nbsp;&nbsp;expire: 整型, 超时时间(秒)
sid: 对象, 会话凭证信息
&nbsp;&nbsp;value: 字符, 会话凭证值
&nbsp;&nbsp;expire: 整型, 超时时间(秒)
</pre>

### 刷新会话凭证(及令牌)
<pre>
<b>URI</b>:
/s/sign/refresh
<b>REQ</b>:
token: 字符, 刷新令牌值
<b>RES</b>:
userid: 整型, 用户ID
token: 对象, 刷新令牌信息
&nbsp;&nbsp;value: 字符, 刷新令牌值
&nbsp;&nbsp;expire: 整型, 超时时间(秒)
sid: 对象, 会话凭证信息
&nbsp;&nbsp;value: 字符, 会话凭证值
&nbsp;&nbsp;expire: 整型, 超时时间(秒)
</pre>

## 三. 支付平台充值回调
TODO:
/p/pay/notify/alipay
/p/pay/notify/yeepay