DELIMITER $$
  -- Creating Procedure to delete the tmp image
  CREATE PROCEDURE DELETE_TMP_IMG(point INT)
  BEGIN
		DECLARE img VARCHAR(255);

		SET img = (SELECT Image_name FROM images_tmp WHERE Point_ID = point);
		DELETE FROM images_tmp WHERE Point_ID = point;
		
		SELECT img as image;
  END;$$
DELIMITER ;