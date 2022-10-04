<?php
class login extends controllers
{
	/* <========== Llamada del constructor ==========> */
	public function __construct()
	{
		session_start();
		if (isset($_SESSION['login'])) {
			header('Location: ' . path . '/');
			die();
		}
		parent::__construct();
	}

	/* <========== Cargar todos los elementos de la pagina ==========> */
	public function login()
	{
		$data['page_tab']         = "Gildan SOP";
		$data['page_favicon']     = "login.ico";
		$data['page_title']       = "Gildan SOP RN4";
		$data['page_breadcrumb']  = "";
		$data['page_description'] = "";
		$data['page_icon']        = "";
		$data['page_link']        = path;
		$data['page_script']      = media . "/js/login.js";
		$this->views->getViews($this, "login", $data);
	}
	
	/* <========== Validación de usuarios ==========> */
	public function loginUser()
	{
		if ($_POST) {
			if (empty($_POST['txtusername']) || empty($_POST['txtpassword'])) {
				$aresponse = array(
					'status' => false,
					'title' => 'Campos obligatorios',
					'msg' => 'Los campos de usuario y contraseñas son obligatorios',
					'icon' => 'error'
				);
			} else {
				$user = strtolower(cleanString($_POST['txtusername']));
				$pass = hash("SHA256", $_POST['txtpassword']);
				$ruser = $this->model->loginUser($user, $pass);

				if (empty($ruser)) {
					$aresponse = array(
						'status' => false,
						'title' => 'Datos Incorrectos',
						'msg' => 'El usuario o la contraseña son incorrectos',
						'icon' => 'error'
					);
				} else {
					$adata = $ruser;

					if ($adata['usr_status'] == 1) {
						$_SESSION['usrid'] = $adata['usr_id'];
						$_SESSION['login'] = true;
						
						$adata = $this->model->sessionLogin($_SESSION['usrid']);

						$aresponse = array(
							'status' => true,
							'title' => 'Bienvenido',
							'msg' => 'Bienvenido ' . $adata['NAME'],
							'icon' => 'success'
						);
					} elseif ($adata['usr_status'] == 2) {
						$aresponse = array(
							'status' => false,
							'title' => 'Inactivo',
							'msg' => 'El usuario ingresado se encuentra inactivo',
							'icon' => 'warning'
						);
					}
				}
			}
			echo json_encode($aresponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}

	/* <========== Cambiar Contraseña ==========> */
	public function setPassword()
	{
		if (empty($_POST['txtid']) || empty($_POST['txtemail']) || empty($_POST['txttoken']) || empty($_POST['txtpassword']) || empty($_POST['txtpassword2'])) {
			$aresponse = array(
				'status' => false,
				'title' => '¡Atención!',
				'msg' => 'Todos los campos son obligatorios',
				'icon' => 'error'
			);
		} else {
			$id = intval($_POST['id']);
			$pass1 = $_POST['txtpassword'];
			$pass2 = $_POST['txtpassword2'];
			$email = cleanString($_POST['email']);
			$token = cleanString($_POST['token']);

			if ($pass1 != $pass2) {
				$aresponse = array(
					'status' => false,
					'title' => '¡Atención!',
					'msg' => 'Las contraseñas no coinciden',
					'icon' => 'error'
				);
			} else {
				$password = hash("SHA256", $pass1);
				$rpassword = $this->model->insertPassword($id, $password);

				if ($rpassword) {
					$aresponse = array(
						'status' => true,
						'title' => '¡Cambio de Contraseña!',
						'msg' => 'La contraseña fue actualizada exitosamente',
						'icon' => 'success'
					);
				} else {
					$aresponse = array(
						'status' => false,
						'title' => '¡Atención!',
						'msg' => 'No es posible realizar el proceso, intente más tarde',
						'icon' => 'error'
					);
				}
			}
		}
		echo json_encode($aresponse, JSON_UNESCAPED_UNICODE);
		die();
	}
}
