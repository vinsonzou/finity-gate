DROP TABLE IF EXISTS game;
CREATE TABLE game
(
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(16) NOT NULL,
  PRIMARY KEY(id)
)
ENGINE = INNODB DEFAULT CHARACTER SET UTF8;