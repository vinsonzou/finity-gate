CREATE TABLE player
(
  userid INT NOT NULL,
  gameid INT NOT NULL,
  serverid INT NOT NULL,
  playerid INT NOT NULL,
  /*TODO player payloads*/
  PRIMARY KEY(userid, gameid, serverid)
)
ENGINE = INNODB DEFAULT CHARACTER SET UTF8;