<?php

class supervisorModel extends Connection {
	
	public function __construct() {
		parent::__construct();
	}

	public function getSupervisorOptions() {
		$sql = " SELECT Supervisor_ID AS id, Nombre AS name FROM supervisores WHERE Area_ID = 2 AND Status = 1";
		return parent::select_all($sql);
	}
}
