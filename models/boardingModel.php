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

	public function getAuditDetail(int $id)
	{
		$query = "SELECT * FROM detalle_auditoria WHERE Nro_Auditoria = $id";

		$req = $this->select_all($query);
		return $req;
	}
}
