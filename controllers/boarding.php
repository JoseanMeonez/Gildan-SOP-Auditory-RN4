<?php

class boarding extends controllers
{
	public function __construct() {
		parent::__construct();
	}

	public function getAudits() {
		$req = $this->model->getAudits();

		for ($i=0; $i < count($req); $i++) { 
			$req[$i]['editar'] = ('
				<button class="btn btn-outline-success btn-sm" onclick="editButton()" title="Editar">
					<i class="fa-solid fa-pen-to-square"></i>
				</button>
			');
		}

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}

	public function getAuditDetailTemp()
	{
		// Here I'm Capsuling the received data
		$id = intval(cleanString($_GET['id']));
		$req = $this->model->getAuditDetailTemp($id, 2);

		// Adding the selection button to data
		for ($i=0; $i < count($req); $i++) {
			$req[$i]['Acciones'] = ('
				<div class="m-1">
					<select class="form-select form_input point_actions mb-1" id="'.bin2hex($req[$i]["punto_id"]).'">
						<option disabled selected>Resultado</option>
						<option value="1" lt="'.bin2hex($req[$i]["punto_id"]).'">Pasa</option>
						<option value="0" lt="'.bin2hex($req[$i]["punto_id"]).'">Falla</option>
						<option value="2" lt="'.bin2hex($req[$i]["punto_id"]).'">No aplica</option>
					</select>

					<input type="file" name="photo" class="add_photo d-none" id="imagen-auditoria">
					<label for="imagen-auditoria" class="form-control btn btn-primary">Agregar una imagen</label>
				</div>
			');
		}

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}

	public function addImageAudit()
	{
		session_start();
		$imgName = '_img' . md5(date('d-m-Y H:m:s')) . '.jpg';

		$req = $this->model->setTempImage($imgName, $_SESSION['userdata']['usr_id']);

		if ($req[1] == 1) {
			uploadImage($_FILES['photo'], $imgName);
			$res = array(
				'status' => true,
				'header' => '¡Proceso exitoso!',
				'subtitle' => 'Hace un momento.',
				'response' => 'La imagen se guardó correctamente en la base de datos.',
				'color' => 1
			);
		} else if ($req[1] == 0) {
			$res = array(
				'status' => false,
				'header' => 'Atención',
				'subtitle' => 'Hace un momento.',
				'response' => 'Debe iniciar la auditoria antes de agregar una imagen.',
				'color' => 3
			);
		} else {
			$res = array(
				'status' => false,
				'header' => '¡Proceso Fallido!',
				'subtitle' => 'Hace un momento.',
				'response' => 'La imagen no se guardó en la base de datos.',
				'color' => 2
			);
		}

		echo json_encode($res, JSON_UNESCAPED_UNICODE);
		die;
	}


	public function setTempAudit()
	{
		session_start();
		date_default_timezone_set('America/Tegucigalpa');

		$user = $_SESSION['userdata']['usr_id'];
		$supervisor = intval($_POST['sup']);
		$point = hex2bin($_POST['pid']);
		$position = intval($_POST['pos']);
		$result = intval($_POST['res']);
		$month = date('m');

		if (!empty($supervisor) and !empty($point) and !empty($position) or $result <= 2) {
			$req = $this->model->setTempAudit($user, $supervisor, $point, $position, $result, $month);

			$res = array(
				'status' => true,
				'color' => 1,
				'title' => 'Datos guardados',
				'subtitle' => 'Ahora',
				'body' => 'Se guardó correctamente el punto auditado.'
			);

		} else if($supervisor < 1) {
			$res = array(
				'status' => false,
				'color' => 3,
				'title' => 'Datos incompletos - Supervisor',
				'subtitle' => 'Ahora',
				'body' => 'No se seleccionó un supervisor del area auditada, favor intente de nuevo.'
			);
		} else {
			$res = array(
				'status' => false,
				'color' => 2,
				'title' => 'Ocurrió un error',
				'subtitle' => 'Ahora',
				'body' => 'No se recibieron datos correctos sobre la auditoria, por favor, refresque la página e intente de nuevo.'
			);
		}


		echo json_encode($res, JSON_UNESCAPED_UNICODE);
		die;
	}

	public function getAuditTemp()
	{
		session_start();
		date_default_timezone_set('America/Tegucigalpa');

		$user = $_SESSION['userdata']['usr_id'];
		$req = $this->model->getTempAudit($user);

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}
}
