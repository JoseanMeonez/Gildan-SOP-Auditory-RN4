<?php
class points extends controllers
{
	public function __construct()
	{
		parent::__construct();
	}

	// Getting all Boarding Points
	public function getBoardingPoints()
	{
		$data = $this->model->getAll_BoardingPoints();
		
		for ($i = 0; $i < count($data); $i++) {
			$data[$i]['id'] = $i + 1;
			$data[$i]['acciones'] = ('
				<button class="btn btn-outline-success btn-sm" onclick="editButton(`'.bin2hex($data[$i]["Punto_ID"]).'`)" title="Editar">
					<i class="fa-solid fa-pen-to-square"></i>
				</button>
			');
		}

		echo json_encode($data, JSON_UNESCAPED_UNICODE);
		die;
	}

	// Getting data of an boarding's auditory point 
	public function editBoarding_data()
	{
		$req = (!empty($_GET['id_crypted'])) ? cleanstring($_GET['id_crypted']) : array(
			'status' => false,
			'header' => '¡Datos erroneos!',
			'subtitle' => 'Hace un momento.',
			'response' => 'Algunos de los datos enviados no es correcto, favor refresque la página e intente de nuevo.',
			'color' => 3
		);

		if (!is_array($req)) {
			$id = intval(hex2bin($req));
			$req = $this->model->getPoint_Boarding($id);

			if (empty($req)) {
				$req = array(
					'status' => false,
					'header' => '¡Datos no encontrados!',
					'subtitle' => 'Hace un momento.',
					'response' => 'Los datos solicitados no fueron encontrados en la base de datos, favor refresque la página e intente de nuevo.',
					'color' => 2
				);
			}
		}

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}
}
