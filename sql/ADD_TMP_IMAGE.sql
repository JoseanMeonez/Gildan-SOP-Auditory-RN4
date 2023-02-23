DELIMITER $$
  -- Creating Procedure to create the tmp image
  CREATE PROCEDURE ADD_TMP_IMAGE(image_name VARCHAR(255), user INT, area INT, point INT)
  BEGIN
		DECLARE audit_id INT;
		DECLARE img_id INT;
		DECLARE prev_name VARCHAR(255);

		SET audit_id = (SELECT Id_Auditoria FROM auditorias_tmp WHERE User_ID = user AND Area_ID = area);
		SET img_id = (SELECT Image_ID FROM images_tmp WHERE Point_ID = point);

		IF audit_id > 0 THEN
			IF img_id > 0 THEN
				SET prev_name = (SELECT Image_name FROM images_tmp WHERE Point_ID = point);
				UPDATE images_tmp SET Image_name = image_name WHERE Point_ID = point;
				SELECT 2 as resultado, prev_name as imagen_anterior;
			ELSE
				INSERT INTO images_tmp(Image_name, Point_ID, Audit_ID, User_ID) VALUES(image_name, point, audit_id, user);
				SELECT 1 as resultado;
			END IF;
		ELSE
			SELECT 0 as resultado;
		END IF;

  END;$$
DELIMITER ;