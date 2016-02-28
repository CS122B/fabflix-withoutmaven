DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `XML_parse_stars`(
  IN firstName VARCHAR(50),
  IN lastName VARCHAR(50),
  IN dob VARCHAR(20)
)
BEGIN
  DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
    START TRANSACTION;
    
    IF NOT EXISTS (SELECT (1) FROM stars WHERE first_name = firstName AND last_name = lastName) THEN
    INSERT INTO `moviedb`.`stars` (
      `first_name`,
      `last_name`,
      `dob`
    ) VALUES (
      firstName,
      lastName,
      str_to_date(dob, '%Y/%m/%d') 
    );
  END IF;
    
    IF `_rollback` THEN
    ROLLBACK;
  ELSE
    COMMIT;
  END IF;
END$$
DELIMITER ;
