DELIMITER $$
  -- Creating Procedure to create the tmp image
  CREATE PROCEDURE ADD_TMP_IMAGE(image_name VARCHAR(255), user INT, area INT)
  BEGIN
		DECLARE audit_id INT;

		SET audit_id = (SELECT Id_Auditoria FROM auditorias_tmp WHERE User_ID = user AND Area_ID = area);

		IF audit_id > 0 THEN
			INSERT INTO images_tmp(Image_name, Audit_ID, User_ID) VALUES(image_name, audit_id, user);
			SELECT 1;
		ELSE
			SELECT 0;
		END IF;

  END;$$
DELIMITER ;