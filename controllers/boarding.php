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
			$req[$i]['acciones'] = ('<div class="m-1">');
			$req[$i]['comment'] = ('
				<div class="form-group form_info mb-1">
					<textarea class="form-control form_textarea comment_input" dataid="'.bin2hex($req[$i]["punto_id"]).'" cols="30" rows="1" placeholder="Escriba un Comentario" style="resize:none; height: 100px;"></textarea>
				</div>
			');

			if ($req[$i]['estado'] == null) {
				$req[$i]['acciones'] .= ('
						<select class="form-select form_input point_actions mb-1" id="'.bin2hex($req[$i]["punto_id"]).'">
							<option disabled selected>Resultado</option>
							<option value="1" lt="'.bin2hex($req[$i]["punto_id"]).'">Pasa</option>
							<option value="3" lt="'.bin2hex($req[$i]["punto_id"]).'">Falla</option>
							<option value="2" lt="'.bin2hex($req[$i]["punto_id"]).'">No aplica</option>
						</select>
	
						<input type="file" name="photo" id="add_photo'.bin2hex($req[$i]["punto_id"]).'" class="add_photo d-none" binid="'.bin2hex($req[$i]["punto_id"]).'">
						<label for="add_photo'.bin2hex($req[$i]["punto_id"]).'" class="form-control btn btn-primary">Agregar una imagen</label>
					</div>
				');
			} else if ($req[$i]['estado'] == 3) {
				$req[$i]['acciones'] .= ('
						<select class="form-select form_input point_actions mb-1" id="'.bin2hex($req[$i]["punto_id"]).'">
							<option disabled>Resultado</option>
							<option value="1" lt="'.bin2hex($req[$i]["punto_id"]).'">Pasa</option>
							<option selected value="3" lt="'.bin2hex($req[$i]["punto_id"]).'">Falla</option>
							<option value="2" lt="'.bin2hex($req[$i]["punto_id"]).'">No aplica</option>
						</select>

						<input type="file" name="photo" id="add_photo'.bin2hex($req[$i]["punto_id"]).'" class="add_photo d-none" binid="'.bin2hex($req[$i]["punto_id"]).'">
						<label for="add_photo'.bin2hex($req[$i]["punto_id"]).'" class="form-control btn btn-primary">Agregar una imagen</label>
					</div>
				');
			} else if ($req[$i]['estado'] == 1) {
				$req[$i]['acciones'] .= ('
						<select class="form-select form_input point_actions mb-1" id="'.bin2hex($req[$i]["punto_id"]).'">
							<option disabled selected>Resultado</option>
							<option selected value="1" lt="'.bin2hex($req[$i]["punto_id"]).'">Pasa</option>
							<option value="3" lt="'.bin2hex($req[$i]["punto_id"]).'">Falla</option>
							<option value="2" lt="'.bin2hex($req[$i]["punto_id"]).'">No aplica</option>
						</select>

						<input type="file" name="photo" id="add_photo'.bin2hex($req[$i]["punto_id"]).'" class="add_photo d-none" binid="'.bin2hex($req[$i]["punto_id"]).'">
						<label for="add_photo'.bin2hex($req[$i]["punto_id"]).'" class="form-control btn btn-primary">Agregar una imagen</label>
					</div>
				');
			} else if ($req[$i]['estado'] == 2) {
				$req[$i]['acciones'] .= ('
						<select class="form-select form_input point_actions mb-1" id="'.bin2hex($req[$i]["punto_id"]).'">
							<option disabled selected>Resultado</option>
							<option value="1" lt="'.bin2hex($req[$i]["punto_id"]).'">Pasa</option>
							<option value="3" lt="'.bin2hex($req[$i]["punto_id"]).'">Falla</option>
							<option selected value="2" lt="'.bin2hex($req[$i]["punto_id"]).'">No aplica</option>
						</select>

						<input type="file" name="photo" id="add_photo'.bin2hex($req[$i]["punto_id"]).'" class="add_photo d-none" binid="'.bin2hex($req[$i]["punto_id"]).'">
						<label for="add_photo'.bin2hex($req[$i]["punto_id"]).'" class="form-control btn btn-primary">Agregar una imagen</label>
					</div>
				');
			}

			if ($req[$i]['img'] != null) {
				$req[$i]['imagenes'] = ('
					<div class="m-1">
						<div class="prevImage rounded shadow-sm">
							<img src="'.media.'/images/uploads/'.$req[$i]['img'].'" style="width:40%;">
						</div>
						<input type="file" name="photo" id="img'.bin2hex($req[$i]["punto_id"]).'" dataid="'.bin2hex($req[$i]["punto_id"]).'" class="inputUploadFile btn">
						<label for="img'.bin2hex($req[$i]["punto_id"]).'" class="btnUploadFile btn btn-sm btn-success mt-2">
							<i class="fas fa-upload"></i>
						</label>
						<button type="button" dataid="'.bin2hex($req[$i]["punto_id"]).'" class="btnDeleteFile btn btn-sm btn-danger">
							<i class="fas fa-trash-alt"></i>
						</button>
					</div>
				');
			} else {
				$req[$i]['imagenes'] = ('
					<div class="card-body">
						<p class="card-text" id="img-comment">No se ha agregado ninguna imagen</p>
						<div class="justify-content-center" id="imagesContainer'.bin2hex($req[$i]["punto_id"]).'"></div>
					</div>
				');
			}
		}

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}

	public function addImageAudit(int $point_id)
	{
		session_start();
		$imgName = '_img' . md5(date('d-m-Y H:m:s')) . '.jpg';
		$point_id = hex2bin($point_id);

		$req = $this->model->setTempImage($imgName, $_SESSION['userdata']['usr_id'], $point_id);

		if ($req['resultado'] == 1) {
			uploadImage($_FILES['photo'], $imgName);

			$res = array(
				'status' => true,
				'header' => '¡Proceso exitoso!',
				'subtitle' => 'Hace un momento.',
				'response' => 'La imagen se guardó correctamente en la base de datos.',
				'color' => 1
			);
		} else if ($req['resultado'] == 2) {
			deleteFile($req['imagen_anterior']);
			uploadImage($_FILES['photo'], $imgName);

			$res = array(
				'status' => true,
				'header' => '¡Proceso exitoso!',
				'subtitle' => 'Hace un momento.',
				'response' => 'La imagen se actualizó correctamente en la base de datos.',
				'color' => 1
			);
		} else if ($req['resultado'] == 0) {
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

	public function deleteImageAudit(int $point_id)
	{
		$point_id = hex2bin($point_id);
		$req = $this->model->deleteTempImage($point_id);

		if ($req['image']) {
			deleteFile($req['image']);

			$res = array(
				'status' => true,
				'header' => '¡Proceso exitoso!',
				'subtitle' => 'Hace un momento.',
				'response' => 'La imagen se borró correctamente en la base de datos.',
				'color' => 1
			);
		} else {
			$res = array(
				'status' => false,
				'header' => '¡Proceso Fallido!',
				'subtitle' => 'Hace un momento.',
				'response' => 'La imagen no se pudo borrar en la base de datos.',
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
