<?php
class dashboardModel extends Connection
{
	public function __construct() {
		parent::__construct();
	}

	public function getAllAuditsDetail()
	{
		$currentYear = date("Y");
		$sql = ("SELECT
			YEAR(a.Fecha) AS Año,
			a.Semana,
			a.Mes,
			ar.Area_Nombre,
			COUNT(d.Auditoria_ID) AS Puntos_Auditados,
			d.Auditoria_ID,
			SUM(CASE WHEN d.Estado = 1 THEN 1 ELSE 0 END) AS Puntos_Pasados,
			SUM(CASE WHEN d.Estado = 3 THEN 1 ELSE 0 END) AS Puntos_Fallados,
			pos.Posicion_Desc,
			(SUM(CASE WHEN d.Estado = 1 THEN 1 ELSE 0 END) / COUNT(d.Auditoria_ID)) as Resultado
			FROM detalle_auditoria d
			INNER JOIN auditorias a ON a.Id_Auditoria = d.Auditoria_ID
			INNER JOIN area ar ON ar.Area_ID = a.Area_ID
			INNER JOIN puntos p ON p.Punto_ID = d.Punto_ID
			LEFT JOIN posiciones pos ON p.Posicion_ID = pos.Posicion_ID
			WHERE YEAR(a.Fecha) = $currentYear AND (d.Estado = 1 OR d.Estado = 3)
			GROUP BY pos.Posicion_Desc, a.Semana
		");

		$req = $this->select_all($sql);
		return $req;
	}

	public function getAuditDetail(int $area, int $year, int $month, int $week)
	{

	}
}