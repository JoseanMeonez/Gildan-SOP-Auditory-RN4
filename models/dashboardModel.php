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
			pl.plant_acronym AS Planta,
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
			INNER JOIN plants_manufacturing pl ON a.Plant_ID = pl.plant_id
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
		$sql = ("SELECT
			YEAR(a.Fecha) AS Año,
			pl.plant_acronym AS Planta,
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
			INNER JOIN plants_manufacturing pl ON a.Plant_ID = pl.plant_id
			INNER JOIN area ar ON ar.Area_ID = a.Area_ID
			INNER JOIN puntos p ON p.Punto_ID = d.Punto_ID
			LEFT JOIN posiciones pos ON p.Posicion_ID = pos.Posicion_ID
			WHERE a.Area_ID = $area AND YEAR(a.Fecha) = $year AND a.Mes = $month AND a.Semana = $week AND (d.Estado = 1 OR d.Estado = 3)
			GROUP BY pos.Posicion_Desc, a.Semana
		");

		$req = $this->select_all($sql);
		return $req;
	}

	public function getYearOptions(int $area)
	{
		$sql = ("SELECT YEAR(Fecha) as Año FROM auditorias WHERE Area_ID = $area GROUP BY YEAR(Fecha)");

		$req = $this->select_all($sql);
		return $req;
	}

	public function getMonthOptions(int $area, int $year)
	{
		$sql = ("SELECT Mes FROM auditorias WHERE Area_ID = $area AND YEAR(Fecha) = $year GROUP BY Mes");

		$req = $this->select_all($sql);
		return $req;
	}

	public function getWeekOptions(int $area, int $year, int $month)
	{
		$sql = ("SELECT Semana FROM auditorias WHERE Area_ID = $area AND YEAR(Fecha) = $year AND Mes = $month");

		$req = $this->select_all($sql);
		return $req;
	}
}