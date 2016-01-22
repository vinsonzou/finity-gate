DROP TABLE IF EXISTS player;
CREATE TABLE player
(
  userid INT NOT NULL,
  serverid INT NOT NULL,
  playerid INT NOT NULL,
  /*TODO player payloads*/
  PRIMARY KEY(userid, serverid)
)
ENGINE = INNODB DEFAULT CHARACTER SET UTF8;