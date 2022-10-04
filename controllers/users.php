<?php
class users extends controllers
{
	// Llamada del constructor
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . path . '/login');
			die();
		}
	}

	// Seleccionar todos los datos que apareceran en la tabla
	public function selectall()
	{
		$aselect = $this->model->selectall();

		$counter = 1;
		for ($i = 0; $i < count($aselect); $i++) {
			$btnEdit = '';
			$btnDele = '';

			$aselect[$i]['id_false'] = $counter++;

			$btnEdit = ('
				<button class="btn btn-outline-success btn-sm btnEdit" rl="' . $aselect[$i]['id'] . '" title="Editar">
					<i class="fa-solid fa-pen-to-square"></i>
				</button>'
			);

			$btnDele = ('
				<button class="btn btn-outline-danger btn-sm btnDele" title="Eliminar">
					<i class="fa-solid fa-trash-can"></i>
				</button>'
			);

			$aselect[$i]['options'] = '<div class="text-center">' . $btnEdit . ' ' . $btnDele . '</div>';
		}

		echo json_encode($aselect, JSON_UNESCAPED_UNICODE);
		die();
	}

	// Buscar un registro
	public function searchUser(int $id)
	{
		$usr_id = intval(cleanString($id));

		if ($usr_id > 0) {
			$adata = $this->model->searchUsers($usr_id);

			if (empty($adata)) {
				$aresponse = array(
					'status' => false,
					'title' => 'Información de Usuarios',
					'msg' => 'Datos no encontrados',
					'icon' => 'error'
				);
			} else {
				$aresponse = array(
					'status' => true,
					'data' => $adata
				);
			}

			echo json_encode($aresponse, JSON_UNESCAPED_UNICODE);
		}
		die();
	}
}
