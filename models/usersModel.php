<?php
class usersModel extends Connection
{
	// Llamada del constructor
	public function __construct()
	{
		parent::__construct();
	}

	/* <========== Seleccionamos los datos que apareceran en la tabla ==========> */
	public function selectall()
	{
		$sql = ("SELECT 
			u.usr_id AS id, u.usr_cname AS name, u.usr_role AS rol_id, r.rol_name AS rol, u.usr_uname AS username, u.usr_status AS status_id, s.st_name AS status 
			FROM tblusers AS u
			INNER JOIN tblroles AS r ON u.usr_role = r.rol_id
			INNER JOIN statusinfo AS s ON u.usr_status = s.st_id
			WHERE usr_status != 3"
		);
		$request = $this->select_all($sql);
		return $request;
	}
}
