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
		WHERE a.Status != 3";
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
			d.Estado as estado
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

	public function getTempAudit(int $user)
	{
		$sql = "SELECT au.Semana, au.Mes, au.Pasa, au.Falla, au.Resultado, COUNT(d.Punto_Auditado) as Auditados FROM auditorias_tmp au INNER JOIN detalle_auditoria_tmp d ON au.Id_Auditoria = d.Nro_auditoria WHERE au.User_ID = $user AND d.User_ID = $user";
		
		return $this->select_all($sql);
	}

	public function setTempImage($name, int $user, int $point)
	{
		$sql = "CALL ADD_TMP_IMAGE('$name', $user, 2, $point)";
		$response = $this->select($sql);

		return $response;
	}
}
