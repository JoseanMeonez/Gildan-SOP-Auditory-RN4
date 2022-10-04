<?php
class loginModel extends Connection
{
	// Cargar constructor de la pagina
	public function __construct()
	{
		parent::__construct();
	}

	// Validación de usuarios
	public function loginUser(string $user, string $pass)
	{
		$sql = "SELECT usr_id, usr_status FROM tblusers WHERE usr_uname = '{$user}' AND usr_upass = '{$pass}' AND usr_status != 3";
		$request = $this->select($sql);

		return $request;
	}

	// Creación de Variables de Sesion de usuario
	public function sessionLogin(int $id)
	{
		$sql = ("SELECT u.usr_id,
			u.usr_cname as NAME,
			u.usr_role,
			r.rol_name,
			u.usr_uname,
			u.usr_upass,
			u.usr_ucreated,
			u.usr_status,
			s.st_name
			FROM tblusers as u 
			INNER JOIN tblroles as r ON u.usr_role = r.rol_id 
			INNER JOIN statusinfo as s ON u.usr_status = s.st_id
			WHERE usr_id = $id"
		);
		$request = $this->select($sql);
		$_SESSION['userdata'] = $request;
		$_SESSION['userdata']['name'] = explode(" ",$request['NAME']);
		return $request;
	}
}
