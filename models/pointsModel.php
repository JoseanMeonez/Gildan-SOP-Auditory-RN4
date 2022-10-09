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
			p.Posicion_ID as posicion,
			p.No_Punto as punto,
			p.Descripcion as descripcion
			FROM puntos p
			INNER JOIN area a ON a.Area_ID = p.Area_ID
			WHERE status = 1 AND p.Area_ID = 2
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
