CREATE TABLE server
(
  id INT NOT NULL AUTO_INCREMENT,
  gameid INT NOT NULL,
  name VARCHAR(32) NOT NULL,
  host VARCHAR(128) NOT NULL,
  port INT NOT NULL,
  PRIMARY KEY(id)
)
ENGINE = INNODB DEFAULT CHARACTER SET UTF8;