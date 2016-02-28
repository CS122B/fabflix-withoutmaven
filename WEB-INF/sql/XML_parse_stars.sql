DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `XML_parse_stars`(
  IN firstName VARCHAR(50),
  IN lastName VARCHAR(50),
  IN dob VARCHAR(20),
    OUT queryStatus INT(11)
)
BEGIN
  DECLARE `_rollback` BOOL DEFAULT 0;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
  START TRANSACTION;

  INSERT INTO `moviedb`.`stars` (
    `first_name`,
    `last_name`,
    `dob`
  ) VALUES (
    firstName,
    lastName,
    str_to_date(dob, '%Y/%m/%d') 
  );

  SET queryStatus = 1;

  IF `_rollback` THEN
  ROLLBACK;
    SET queryStatus = 0;
  ELSE
    COMMIT;
  END IF;
END$$
DELIMITER ;
