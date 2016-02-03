DROP TABLE IF EXISTS pay;
CREATE TABLE pay
(
  id INT NOT NULL AUTO_INCREMENT,
  userid INT NOT NULL,
  serverid INT NOT NULL,
  fee INT NOT NULL, /*订单金额(分)*/
  createtime INT NOT NULL, /*创建时间*/
  extra VARCHAR(128), /*订单描述信息*/

  platform VARCHAR(16) NOT NULL, /*支付平台*/
  orderid VARCHAR(32) NOT NULL, /*支付平台单号*/
  notifyfee INT, /*支付平台实际付费金额*/
  notfiytime INT, /*支付平台通知时间*/
  PRIMARY KEY(id)
)
ENGINE = INNODB DEFAULT CHARACTER SET UTF8;