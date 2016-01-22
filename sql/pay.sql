DROP TABLE IF EXISTS pay;
CREATE TABLE pay
(
  id INT NOT NULL AUTO_INCREMENT,
  userid INT NOT NULL,
  serverid INT NOT NULL,
  fee INT NOT NULL, /*order fee in cents*/
  createtime INT NOT NULL, /*order created time in seconds*/
  extra VARCHAR(128), /*extra description for this order*/

  notifyid VARCHAR(32), /*3rd-party order serial number*/
  notifyfee INT, /*3rd-party fee really payed*/
  notfiytime INT, /*3rd-party notify time in seconds*/
  PRIMARY KEY(id)
)
ENGINE = INNODB DEFAULT CHARACTER SET UTF8;