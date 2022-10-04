<?php
class rolesModel extends Connection
{
	// Getting the connection to the database
	public function __construct()
	{
		parent::__construct();
	}

	// Getting every role from the db where there aren't eliminated --status 3
	public function selectall()
	{
		$sql = ("SELECT r.rol_id, r.rol_name, r.rol_description, r.rol_ucreated, r.rol_status, s.st_name 
			FROM tblroles AS r
			INNER JOIN tblstatus AS s ON r.rol_status = s.st_id
			WHERE r.rol_status != 3"
		);
		return $this->select_all($sql);
	}

	// Search a register
	public function searchRole(int $idrole)
	{
		$sql = "SELECT * FROM tblroles WHERE rol_id = $idrole";
		$request = $this->select($sql);

		return $request;
	}

	// Select a register
	public function getRoles()
	{
		$sql = "SELECT * FROM tblroles WHERE rol_status != 3";
		$request = $this->select_all($sql);
		return $request;
	}
}
