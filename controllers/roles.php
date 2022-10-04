<?php
class roles extends controllers
{
	/* <========== Constructor Call ==========> */
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . path . '/login');
			die();
		}
	}

	// Loading elements and data on the page
	public function roles()
	{
		$data['page_tab'] = 'Nombre de la aplicación';
		$data['page_favicon'] = 'favicon.ico';
		$data['page_title'] = 'Listado de Roles';
		$data['page_breadcrumb'] = 'Roles';
		$data['page_description'] = 'Listado de roles de los empleados y permisos de uso';
		$data['page_icon'] = 'fa-solid fa-user-tag';
		$data['page_link'] = path;
		$data['page_script'] = media . '/js/roles.js';
		$this->views->getViews($this, "roles", $data);
	}

	/* <========== Select the data that will appear in the table ==========> */
	public function selectall()
	{
		$aselect = $this->model->selectall();

		$counter = 1;
		for ($i = 0; $i < count($aselect); $i++) {
			$btnPerm = '';
			$btnEdit = '';
			$btnDele = '';

			$aselect[$i]['id']          = '<div class="text-center">' . $counter++ . '</div>';
			$aselect[$i]['name']        = '<div class="text-left">' . $aselect[$i]['rol_name'] . '</div>';
			$aselect[$i]['description'] = '<div class="text-left">' . $aselect[$i]['rol_description'] . '</div>';
			$aselect[$i]['created']     = '<div class="text-center">' . $aselect[$i]['rol_ucreated'] . '</div>';
			if ($aselect[$i]['rol_status'] == 1) {
				$status = '<i class="fa-solid fa-circle-check" style="color: green; font-size: 1.5rem" title=' . $aselect[$i]['stt_name'] . '></i>';
			} elseif ($aselect[$i]['rol_status'] == 2) {
				$status = '<i class="fa-solid fa-circle-minus" style="color: orange; font-size: 1.5rem" title=' . $aselect[$i]['stt_name'] . '></i>';
			} elseif ($aselect[$i]['rol_status'] == 3) {
				$status = '<i class="fa-solid fa-circle-xmark" style="color: red; font-size: 1.5rem" title=' . $aselect[$i]['stt_name'] . '></i>';
			}
			$aselect[$i]['status']      = '<div class="text-center">' . $status . '</div>';
			$btnPerm = '<button class="btn btn-outline-secondary btn-sm btnPerm" rl="' . $aselect[$i]['rol_id'] . '" title="Permisos">
                              <i class="fa-solid fa-key"></i>
                           </button>';

			$btnEdit = '<button class="btn btn-outline-success btn-sm btnEdit" rl="' . $aselect[$i]['rol_id'] . '" title="Editar">
                              <i class="fa-solid fa-pen-to-square"></i>
                           </button>';

			$btnDele = '<button class="btn btn-outline-danger btn-sm btnDele" rl="' . $aselect[$i]['rol_id'] . '" rn = "' . $aselect[$i]['rol_name'] . '" title="Eliminar">
                              <i class="fa-solid fa-trash-can"></i>
                           </button>';
			$aselect[$i]['options']     = '<div class="text-center">' . $btnPerm . ' ' . $btnEdit . ' ' . $btnDele . '</div>';
		}

		echo json_encode($aselect, JSON_UNESCAPED_UNICODE);
		die();
	}

	// Getting data about the roles 
	public function searchRole(int $role_id)
	{
		$roleid = intval(cleanString($role_id));

		if ($roleid > 0) {
			$adata = $this->model->searchRole($roleid);

			if (empty($adata)) {
				$aresponse = array(
					'status' => false,
					'title' => 'Información de Roles',
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

	// Formatting the Roles from the db into a comboBox
	public function getRoles()
	{
		$htmlOptions = "";
		$adata = $this->model->getRoles();

		if (count($adata) > 0) {
			$htmlOptions .= '<option selected disabled>Seleccione...</option>';
			for ($i = 0; $i < count($adata); $i++) {
				$htmlOptions .= '<option value="' . $adata[$i]['rol_id'] . '">' . $adata[$i]['rol_name'] . '</option>';
			}
		}

		echo $htmlOptions;
		die();
	}
}
