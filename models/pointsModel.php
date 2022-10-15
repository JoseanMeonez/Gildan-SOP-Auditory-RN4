<?php

class pointsModel extends Connection
{

	public function __construct()
	{
		parent::__construct();
	}

	public function getAll_BoardingPoints()
	{
		$sql = ("SELECT 
			p.Punto_ID,
			a.Area_Nombre as area,
			po.Posicion_Desc as posicion,
			p.No_Punto as punto,
			p.Descripcion as descripcion
			FROM puntos p
			INNER JOIN area a ON a.Area_ID = p.Area_ID
			INNER JOIN posiciones po ON po.Posicion_ID = p.Posicion_ID
			WHERE p.Status = 1 AND p.Area_ID = 2
		");

		return parent::select_all($sql);
	}

	public function getPoint_Boarding($id)
	{
		$sql = ("SELECT 
			p.Punto_ID as id,
			p.No_Punto as punto,
			p.Descripcion as descripcion
			FROM puntos p
			WHERE status = 1 AND p.Area_ID = 2 AND p.Punto_ID = $id
		");
		return parent::select($sql);
	}
}
