DELIMITER $$
  -- Creating Procedure to create the tmp audit detail
  CREATE PROCEDURE ADD_TMP_AUDIT_DETAIL(area INT,pos INT, sup INT, user INT, month INT, point_id INT, state_a INT)
  BEGIN
		DECLARE audit_id INT;
		DECLARE week INT;
		DECLARE fails INT;
		DECLARE passes INT;
		DECLARE na INT;
		DECLARE result DOUBLE;
		DECLARE verification INT;
		DECLARE plant INT;

		-- Setting variables
		SET audit_id = (SELECT Id_Auditoria FROM auditorias_tmp WHERE User_ID = user AND Area_ID = area);
		SET week = (SELECT Semana FROM auditorias WHERE Mes = month ORDER BY Id_Auditoria DESC LIMIT 1) + 1;
		SET verification = (SELECT Detalle_id FROM detalle_auditoria_tmp d WHERE d.Punto_Auditado = point_id);
		SET plant = (SELECT plant_id FROM plants_manufacturing p INNER JOIN area a ON a.Area_Plant = p.plant_id  WHERE a.Area_ID = area);

		IF audit_id > 0 THEN
			-- Inserting details
			IF verification > 0 THEN
				UPDATE detalle_auditoria_tmp d SET d.Estado = state_a WHERE d.Punto_Auditado = point_id;
			ELSE
				INSERT INTO detalle_auditoria_tmp(Nro_auditoria, Posicion_id, Supervisor, User_ID, Punto_Auditado, Estado)
				VALUES(audit_id, pos, sup, user, point_id, state_a);
			END IF;

			-- Setting counting
			SET fails = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 3 AND User_ID = user);
			SET passes = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 1 AND User_ID = user);
			SET na = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 2 AND User_ID = user);
			SET result = (SELECT (passes / ((SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE  User_ID = user) - na)));

			-- Updating audit table
			UPDATE auditorias_tmp a SET a.Pasa = passes, a.Falla = fails, a.Resultado = result WHERE a.User_ID = User_ID AND a.Area_ID = area;
		ELSE
			-- Creating tmp audit
			IF week > 0 THEN
				INSERT INTO auditorias_tmp(Supervisor_ID, User_ID, Plant_ID, Fecha, Semana, Mes, Area_ID, Pasa, Falla, Resultado, Status)
				VALUES (sup, user, plant, NOW(), week, month, area,0,0,0,1);
			ELSE
				INSERT INTO auditorias_tmp(Supervisor_ID, User_ID, Plant_ID, Fecha, Semana, Mes, Area_ID, Pasa, Falla, Resultado, Status)
				VALUES (sup, user, plant, NOW(), 1, month, area,0,0,0,1);
			END IF;

			-- Updating audit id
			SET audit_id = (SELECT Id_Auditoria FROM auditorias_tmp WHERE User_ID = user AND Area_ID = area);

			-- Inserting details
			INSERT INTO detalle_auditoria_tmp(Nro_auditoria, Posicion_id, Supervisor, User_ID, Punto_Auditado, Estado)
			VALUES(audit_id, pos, sup, user, point_id, state_a);

			-- Setting counting
			SET fails = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 3 AND User_ID = user);
			SET passes = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 1 AND User_ID = user);
			SET na = (SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE Estado = 2 AND User_ID = user);
			SET result = (SELECT (passes / ((SELECT COUNT(Estado) FROM detalle_auditoria_tmp WHERE  User_ID = user) - na)));

			-- Updating audit table
			UPDATE auditorias_tmp a SET a.Pasa = passes, a.Falla = fails, a.Resultado = result WHERE a.User_ID = User_ID AND a.Area_ID = area;
		END IF;

  END;$$
DELIMITER ;