<?php

class positionsModel extends Connection
{
	public function __construct()
	{
		parent::__construct();
	}

	public function getComboBoxData(int $area)
	{
		$sql = ("SELECT
			Posicion_ID as id,
			Posicion_Desc as descr
			FROM posiciones
			WHERE Area_ID = $area
		");

		return parent::select_all($sql);
	}
}