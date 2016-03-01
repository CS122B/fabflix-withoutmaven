DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `XML_parse_movies`(
  IN mTitle VARCHAR(100),
  IN mDirector VARCHAR(100),
  IN mYear VARCHAR(50),
    IN mGenre VARCHAR(32)
)
BEGIN
  DECLARE movieId INT(11);
  DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;

    START TRANSACTION;
    
  INSERT INTO `moviedb`.`movies` (
    `title`,
    `year`,
    `director`
  ) VALUES (
    mTitle,
    mYear,
    mDirector
  );
    
  SELECT LAST_INSERT_ID() INTO @movieId;
    
    IF NOT EXISTS (SELECT (1) FROM genres WHERE name = mGenre) THEN
    INSERT INTO `moviedb`.`genres`
    (`name`)
    VALUES
    (mGenre);

        INSERT INTO `moviedb`.`genres_in_movies`
    (`genre_id`,
    `movie_id`)
    VALUES
    (LAST_INSERT_ID(),
    @movieId);
  ELSE
        INSERT INTO `moviedb`.`genres_in_movies`
    (`genre_id`,
    `movie_id`)
    VALUES
    ((SELECT id FROM genres WHERE name = mGenre),
    @movieId);
  END IF;
    
    IF `_rollback` THEN
    ROLLBACK;
  ELSE
    COMMIT;
  END IF;
END$$
DELIMITER ;
