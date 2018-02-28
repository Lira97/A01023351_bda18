--2º
CREATE TABLE `sakila`.`LOG_FILM` (
		`id` INT NOT NULL AUTO_INCREMENT,
		`tipo` VARCHAR(45) NULL,
		`filmId` VARCHAR(45) NULL,
		`last_value` VARCHAR(45) NULL,
		`new_Value` VARCHAR(45) NULL,
		`Timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY (`id`));
        
--3º
USE `sakila`;
DROP procedure IF EXISTS `new_procedure`;

DELIMITER $$
USE `sakila`$$
CREATE PROCEDURE `new_procedure` (IN fil INT,IN last_ INT,IN new_ INT)
BEGIN
DECLARE film INT DEFAULT 0;
DECLARE LV INT DEFAULT 0;
DECLARE NV INT DEFAULT 0;

SET film = fil;
SET LV = last_;
SET NV = new_;
    
INSERT INTO LOG_FILM(filmId,last_value,new_Value) VALUES (film,LV,NV);
END$$

DELIMITER ;

--4º
DELIMITER $$
CREATE TRIGGER insert_dato AFTER UPDATE ON film
      FOR EACH ROW  
      BEGIN 
      CALL new_procedure (NEW.film_id, OLD.original_language_id, NEW.original_language_id);
END
DELIMITER ;

--5º
DELIMITER $$
CREATE PROCEDURE IDIOMAS()
  BEGIN
    DECLARE done int DEFAULT FALSE;
    DECLARE ID int;
    DECLARE cur CURSOR FOR SELECT film_id FROM film;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;

    OPEN cur;
    read_loop: LOOP
      FETCH cur INTO ID;

      IF done THEN
        LEAVE read_loop;
      END IF;

      IF (SELECT CATEGORY_ID FROM FILM_CATEGORY WHERE film_id = ID) = 6 THEN UPDATE film SET original_language_id=2 WHERE film_id = ID;
      ELSEIF (SELECT CATEGORY_ID FROM FILM_CATEGORY WHERE film_id = ID) = 9 THEN UPDATE film SET original_language_id=3 WHERE film_id = ID;
      ELSEIF (SELECT COUNT(*) FROM FILM_ACTOR WHERE film_id = ID AND actor_id=31) = 1 THEN UPDATE film SET original_language_id=6 WHERE film_id = ID;
      ELSEIF (SELECT COUNT(*) FROM FILM_ACTOR WHERE film_id = ID AND actor_id=3) = 1 THEN UPDATE film SET original_language_id=4 WHERE film_id = ID;
      ELSEIF (SELECT COUNT(*) FROM FILM_ACTOR WHERE film_id = ID AND actor_id=34) = 1 THEN UPDATE film SET original_language_id=5 WHERE film_id = ID;
      ELSE UPDATE film SET original_language_id=1 WHERE film_id = ID;
      END IF;
    END LOOP;
    CLOSE cur;
  END $$
DELIMITER ;

CALL IDIOMAS();

--6ª
CREATE TABLE MARY_GOMITAS(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  nombre VARCHAR(150) NOT NULL,
  precio DECIMAL(10,6) NOT NULL,
  cstart DATE NOT NULL,
  cend DATE NOT NULL,
  period business_time(cstart, cend),
  PRIMARY KEY(ID, business_time WITHOUT overlaps)
);

INSERT INTO MARY_GOMITAS (nombre, precio, cstart, cend) VALUES
  ('cuadrada', 45, '2018-1-1', '2019-1-1'),
  ('circular', 76, '2018-1-1', '2019-1-1'),
  ('tringular', 93, '2018-1-1', '2019-1-1'),
  ('panditas ', 823, '2018-1-1', '2019-1-1'),
  ('piña', 23, '2018-1-1', '2019-1-1'),
  ('fresa', 23, '2018-1-1', '2019-1-1'),
  ('melon', 554, '2018-1-1', '2019-1-1'),
  ('pingunos', 20, '2018-1-1', '2019-1-1'),
  ('sandia', 89, '2018-1-1', '2019-1-1'),
  ('limon', 18, '2018-1-1', '2019-1-1'),
  ('mango', 12, '2018-1-1', '2019-1-1'),
  ('franbueza', 10, '2018-1-1', '2019-1-1');

UPDATE MARY_GOMITAS
FOR PORTION OF BUSINESS_TIME FROM '2018-2-1' to '2019-1-1'
  SET PRICE = PRICE*1.45;

UPDATE MARY_GOMITAS
FOR PORTION OF BUSINESS_TIME FROM '2018-2-15' to '2019-1-1'
  SET PRICE = (PRICE/1.45)*1.1;

UPDATE MARY_GOMITAS
FOR PORTION OF BUSINESS_TIME FROM '2018-4-25' to '2019-1-1'
  SET PRICE = PRICE*1.45;

  UPDATE MARY_GOMITAS
FOR PORTION OF BUSINESS_TIME FROM '2018-5-5' to '2019-1-1'
  SET PRICE = (PRICE/1.45)*1.1;

UPDATE MARY_GOMITAS
FOR PORTION OF BUSINESS_TIME FROM '2018-10-25' to '2019-1-1'
  SET PRICE = PRICE*1.45;

UPDATE MARY_GOMITAS
FOR PORTION OF BUSINESS_TIME FROM '2018-11-5' to '2019-1-1'
  SET PRICE = (PRICE/1.45)*1.1;

SELECT * from MARY_GOMITAS WHERE NAME='cuadrada';

SELECT SUM(PRICE)/COUNT(*) as AVG from MARY_GOMITAS WHERE NAME='cuadrada';

SELECT MAX(PRICE) as MAX from MARY_GOMITAS WHERE NAME='cuadrada';

SELECT MIN(PRICE) as MAX from MARY_GOMITAS WHERE NAME='cuadrada';