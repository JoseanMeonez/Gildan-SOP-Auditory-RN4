<?php
class boardingModel extends Connection
{
	public function __construct() {
		parent::__construct();
	}

	public function getAudits()
	{
		$query = "SELECT
			a.Id_Auditoria,
			a.Fecha,
			a.Semana,
			a.Mes,
			b.Area_Nombre,
			a.Pasa,
			a.Falla,
			a.Resultado
			FROM auditorias a INNER JOIN area b ON a.Area_ID = b.Area_ID
		WHERE a.Status != 3 and a.Area_ID = 2";
		$req = $this->select_all($query);
		return $req;
	}

	public function getFinalDetail(int $auditid)
	{
		$sql = ("SELECT 
			p.Punto_ID as punto_id,
			po.Posicion_Desc as posicion_desc,
			p.No_Punto as punto,
			p.Descripcion as punto_desc,
			img.Image_name as img,
			d.Estado as estado,
			d.Comentario as comentario
			FROM puntos p
			INNER JOIN posiciones po ON po.Posicion_ID = p.Posicion_ID
			LEFT JOIN detalle_auditoria d ON d.Punto_ID = p.Punto_ID
			LEFT JOIN images img ON img.Point_ID = p.Punto_ID AND img.Audit_ID = d.Auditoria_ID
			WHERE d.Auditoria_ID = $auditid AND d.Estado != 2
		");

		return $this->select_all($sql);		
	}

	public function getPassedAuditsDetails(int $auditid)
	{
		$query = "SELECT
			a.Semana,
			a.Mes,
			COUNT(d.Auditoria_ID) AS Puntos_Auditados,
			d.Auditoria_ID,
			SUM(CASE WHEN d.Estado = 1 THEN 1 ELSE 0 END) AS Puntos_Pasados,
			SUM(CASE WHEN d.Estado = 3 THEN 1 ELSE 0 END) AS Puntos_Fallados,
			pos.Posicion_Desc,
			(SUM(CASE WHEN d.Estado = 1 THEN 1 ELSE 0 END) / COUNT(d.Auditoria_ID)) as Resultado
		FROM detalle_auditoria d
		INNER JOIN auditorias a ON a.Id_Auditoria = d.Auditoria_ID
		INNER JOIN puntos p ON p.Punto_ID = d.Punto_ID
		LEFT JOIN posiciones pos ON p.Posicion_ID = pos.Posicion_ID
		WHERE d.Auditoria_ID = $auditid AND (d.Estado = 1 OR d.Estado = 3)
		GROUP BY pos.Posicion_Desc";
		$req = $this->select_all($query);
		return $req;
	}

	public function getFailedAuditsDetails(int $auditid)
	{
		$query = "SELECT
			a.Semana,
			a.Mes,
			COUNT(d.Auditoria_ID) AS Puntos_Auditados,
			d.Auditoria_ID,
			SUM(d.Estado) as Puntos_Pasados,
			pos.Posicion_Desc,
			(SUM(d.Estado)/COUNT(d.Auditoria_ID)) as Resultado
			FROM detalle_auditoria d
			INNER JOIN auditorias a ON a.Id_Auditoria = d.Auditoria_ID
			INNER JOIN puntos p ON p.Punto_ID = d.Punto_ID
			LEFT JOIN posiciones pos ON p.Posicion_ID = pos.Posicion_ID
			WHERE d.Auditoria_ID = $auditid AND d.Estado = 3 GROUP BY pos.Posicion_Desc";
		$req = $this->select_all($query);
		return $req;
	}

	public function getAuditDetailTemp(int $id, int $area)
	{
		$sql = ("SELECT 
			p.Punto_ID as punto_id,
			po.Posicion_Desc as posicion_desc,
			p.No_Punto as punto,
			p.Descripcion as punto_desc,
			img.Image_name as img,
			d.Estado as estado,
			d.Comentario as comentario
			FROM puntos p
			INNER JOIN posiciones po ON po.Posicion_ID = p.Posicion_ID
			LEFT JOIN images_tmp img ON img.Point_ID = p.Punto_ID
			LEFT JOIN detalle_auditoria_tmp d ON d.Punto_Auditado = p.Punto_ID
			WHERE p.Status = 1 AND p.Area_ID = $area AND p.Posicion_ID = $id
		");

		return $this->select_all($sql);
	}

	public function setTempAudit(int $user, int $supervisor, int $point, int $position, int $result, int $month){
		$sql = "CALL ADD_TMP_AUDIT_DETAIL(?, ?, ?, ?, ?, ?, ?)";
		$data = array(2, $position, $supervisor, $user, $month, $point, $result);

		return $this->insert($sql, $data);
	}

	public function setTempComment(int $user, int $supervisor, int $point, int $position, int $result, int $month, string $comment)
	{
		$sql = "CALL ADD_TMP_COMMENT(2, $position, $supervisor, $user, $month, $point, $result, '$comment')";

		return $this->select($sql);
	}

	public function getTempAudit(int $user)
	{
		$sql = "SELECT au.Semana, au.Mes, au.Pasa, au.Falla, au.Resultado, (COUNT(d.Punto_Auditado) - (SELECT COUNT(d.Punto_Auditado) FROM detalle_auditoria_tmp d WHERE d.Estado = 2)) as Auditados FROM auditorias_tmp au INNER JOIN detalle_auditoria_tmp d ON au.Id_Auditoria = d.Nro_auditoria WHERE au.User_ID = $user AND d.User_ID = $user";
		
		return $this->select_all($sql);
	}

	public function setTempImage($name, int $user, int $point)
	{
		$sql = "CALL ADD_TMP_IMAGE('$name', $user, 2, $point)";
		$response = $this->select($sql);

		return $response;
	}

	public function deleteTempImage(int $point)
	{
		$sql = "CALL DELETE_TMP_IMG($point)";
		$response = $this->select($sql);

		return $response;
	}

	public function AuditCompleted(int $user)
	{
		$sql = "CALL AUDIT_COMPLETED(2, $user)";
		$response = $this->select($sql);

		return $response;
	}
}
