<?php

class Boarding extends controllers
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

	public function getAuditDetail()
	{
		$id = intval(cleanString($_GET['id']));
		$req = $this->model->getAuditDetail($id);
		for ($i=0; $i < count($req); $i++) {
			$req[$i]['Imagenes'] = ('
				<button class="btn btn-outline-primary btn-sm" title="Editar">
					<i class="fa-solid fa-eye"></i>
				</button>				
			');
			$req[$i]['Acciones'] = ('
				<button class="btn btn-outline-success btn-sm" title="Editar">
					<i class="fa-solid fa-pen-to-square"></i>
				</button>
			');
		}

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}

	public function addImageAudit()
	{
		$imgName = '_img' . md5(date('d-m-Y H:m:s')) . '.jpg';
		uploadImage($_FILES['photo'], $imgName);

		$req = array(
			'status' => true,
			'header' => '¡Proceso exitoso!',
			'subtitle' => 'Hace un momento.',
			'response' => 'La imagen se guardó correctamente en la base de datos.',
			'color' => 1
		);

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}

}
