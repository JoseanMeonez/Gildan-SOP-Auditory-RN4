DELIMITER $$
  -- Creating Procedure to update the tmp audit detail comment
  CREATE PROCEDURE ADD_TMP_COMMENT(area INT,pos INT, sup INT, user INT, month INT, point_id INT, state_a INT, comment VARCHAR(255))
  BEGIN
		DECLARE audit_id INT;
		DECLARE verification INT;

		-- Setting variables
		SET audit_id = (SELECT Id_Auditoria FROM auditorias_tmp WHERE User_ID = user AND Area_ID = area);
		SET verification = (SELECT Detalle_id FROM detalle_auditoria_tmp d WHERE d.Punto_Auditado = point_id);

		IF audit_id > 0 THEN
			IF verification > 0 THEN
				UPDATE detalle_auditoria_tmp d SET d.Estado = state_a, d.Comentario = comment  WHERE d.Punto_Auditado = point_id;
				SELECT 2;
			ELSE
				INSERT INTO detalle_auditoria_tmp(Nro_auditoria, Posicion_id, Supervisor, User_ID, Punto_Auditado, Estado)
				VALUES(audit_id, pos, sup, user, point_id, state_a);
				SELECT 1;
			END IF;
		ELSE
			-- Creating tmp audit
			INSERT INTO auditorias_tmp(Supervisor_ID, User_ID, Fecha, Semana, Mes, Area_ID, Pasa, Falla, Resultado, Status)
			VALUES (sup, user, NOW(), week, month, area,0,0,0,1);

			IF verification > 0 THEN
				UPDATE detalle_auditoria_tmp d SET d.Estado = state_a, d.Comentario = comment  WHERE d.Punto_Auditado = point_id;
				SELECT 2;
			ELSE
				INSERT INTO detalle_auditoria_tmp(Nro_auditoria, Posicion_id, Supervisor, User_ID, Punto_Auditado, Comentario,Estado)
				VALUES(audit_id, pos, sup, user, point_id, comment, state_a);
				SELECT 1;
			END IF;

		END IF;
  END;$$
DELIMITER ;