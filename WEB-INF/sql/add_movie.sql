DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_movie`(
  IN movieTitle VARCHAR(100),
  IN movieYear INT(11),
  IN movieDirector VARCHAR(100),
  IN movieBanner VARCHAR(200),
  IN movieTrailer VARCHAR(200),
  IN starFirstName VARCHAR(50),
  IN starLastName VARCHAR(50),
  IN movieGenre VARCHAR(32),
  OUT queryStatus INT(11)
)
BEGIN
  DECLARE movieId INT(11);

  DECLARE `_rollback` BOOL DEFAULT 0;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
  START TRANSACTION;

  IF NOT EXISTS (SELECT (1) FROM movies WHERE title = movieTitle) THEN
    INSERT INTO `moviedb`.`movies` (
      `title`,
      `year`,
      `director`,
      `banner_url`,
      `trailer_url`
    ) VALUES (
      movieTitle,
      movieYear,
      movieDirector,
      movieBanner,
      movieTrailer
    );

    SELECT @movieId := LAST_INSERT_ID();
    SET queryStatus = 1;
  ELSE
    SELECT @movieId := id FROM movies WHERE title = movieTitle;
    SET queryStatus = 2;

    UPDATE `moviedb`.`movies`
    SET
      `title` = movieTitle,
      `year` = movieYear,
      `director` = movieDirector,
      `banner_url` = movieBanner,
      `trailer_url` = movieTrailer
    WHERE `id` = @movieId;
  END IF;

  IF NOT EXISTS (SELECT (1) FROM stars WHERE first_name = starFirstName AND last_name = starLastName) THEN
    INSERT INTO `moviedb`.`stars` (
      `first_name`,
      `last_name`
    ) VALUES (
      starFirstName,
      starLastName
    );

    INSERT INTO `moviedb`.`stars_in_movies` (
      `star_id`,
      `movie_id`
    ) VALUES (
      LAST_INSERT_ID(),
      @movieId
    );
  ELSE
    INSERT INTO `moviedb`.`stars_in_movies` (
      `star_id`,
      `movie_id`
    ) VALUES (
      (SELECT id FROM stars WHERE first_name = starFirstName AND last_name = starLastName),
      @movieId
    );
  END IF;

  IF NOT EXISTS (SELECT (1) FROM genres WHERE name = movieGenre) THEN
    INSERT INTO `moviedb`.`genres` (
      `name`
    ) VALUES (
      movieGenre
    );

    INSERT INTO `moviedb`.`genres_in_movies` (
      `genre_id`,
      `movie_id`
    ) VALUES (
      LAST_INSERT_ID(),
      @movieId
    );
  ELSE
    INSERT INTO `moviedb`.`genres_in_movies` (
      `genre_id`,
      `movie_id`
    ) VALUES (
      (SELECT id FROM genres WHERE name = movieGenre),
      @movieId
    );
  END IF;

  IF `_rollback` THEN
    ROLLBACK;
    SET queryStatus = 0;
  ELSE
    COMMIT;
  END IF;
END$$
DELIMITER ;
