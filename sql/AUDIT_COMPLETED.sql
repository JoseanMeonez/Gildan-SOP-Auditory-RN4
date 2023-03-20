DELIMITER $$
  -- Creating Procedure to migrate the tmp audit and it's detail to the main table
  CREATE PROCEDURE AUDIT_COMPLETED(area INT, id_user INT)
  BEGIN
		DECLARE registers INT;
		DECLARE area_points INT;
		DECLARE new_audit_id INT;

		-- Counting area's audit points
		SET area_points = (SELECT COUNT(*) FROM puntos WHERE Area_ID = area);

    -- Checking if exists a detail list from the actual user
    SET registers = (SELECT COUNT(*) FROM detalle_auditoria_tmp WHERE User_ID = id_user);

    -- Inserting audit detail if is there registers in the temp_detail table
    IF registers = area_points THEN
			-- Inserting the new audit
			INSERT INTO auditorias(Supervisor_ID, User_ID, Fecha, Semana, Mes, Area_ID, Pasa, Falla, Resultado, Status)
			SELECT t.Supervisor_ID, t.User_ID, t.Fecha, t.Semana, t.Mes, t.Area_ID, t.Pasa, t.Falla, t.Resultado, t.Status
			FROM auditorias_tmp t;

			-- Setting last audit id on variable
			SET new_audit_id = (SELECT Id_Auditoria FROM auditorias WHERE User_ID = id_user ORDER by Id_Auditoria DESC LIMIT 1);

			-- Inserting the audit details from the tmp table
			INSERT INTO detalle_auditoria(Auditoria_ID, Posicion_ID, Supervisor_ID, User_ID, Punto_ID, Comentario, Estado)
			SELECT new_audit_id, t.Posicion_id, t.Supervisor, t.User_ID, t.Punto_Auditado, t.Comentario, t.Estado
			FROM detalle_auditoria_tmp t;

			DELETE FROM detalle_auditoria_tmp WHERE User_ID = id_user;
			DELETE FROM auditorias_tmp WHERE User_ID = id_user;

      SELECT 1;
    ELSE
			IF registers > area_points THEN
				SELECT 2;
			ELSE
  	    SELECT 3;
	    END IF;
    END IF;

		-- 1 => Audit completed
		-- 2 => There are more points registered by the user than the amount corresponding to the area
		-- 3 => Uncomplete audit
	END;$$
DELIMITER ;