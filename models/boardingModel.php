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

	public function getAuditDetail(int $id, int $area)
	{
		$sql = ("SELECT 
			p.Punto_ID as punto_id,
			po.Posicion_Desc as posicion_desc,
			p.No_Punto as punto,
			p.Descripcion as punto_desc
			FROM puntos p
			INNER JOIN posiciones po ON po.Posicion_ID = p.Posicion_ID
			WHERE p.Status = 1 AND p.Area_ID = $area
		");

		return $this->select_all($sql);
	}
}
