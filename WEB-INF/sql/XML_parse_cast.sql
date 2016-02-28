DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `XML_parse_cast`(
  IN mTitle VARCHAR(100),
    IN sFirstName VARCHAR(50),
    IN sLastName VARCHAR(50),
    OUT queryStatus INT(11)
)
BEGIN
  DECLARE movieId INT(11);
  DECLARE starId INT(11);
  DECLARE `_rollback` BOOL DEFAULT 0;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;

  START TRANSACTION;

  SET queryStatus = 0;

  SELECT @movieId := 
    id
    FROM movies
    WHERE title = mTitle
    LIMIT 1;

  SELECT @starId :=
    id
    FROM stars
    WHERE first_name = sFirstName
      AND last_name = sLastName
    LIMIT 1;

  IF (@movieId IS NOT NULL AND @starId IS NOT NULL) THEN
    INSERT INTO `moviedb`.`stars_in_movies` (
      `star_id`,
      `movie_id`
    ) VALUES (
      @starId,
      @movieId
    );

    SET queryStatus = 1;
  END IF;
    
  IF `_rollback` THEN
    SET queryStatus = 0;
    ROLLBACK;
  ELSE
    COMMIT;
  END IF;
END$$
DELIMITER ;
