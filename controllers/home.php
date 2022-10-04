<?php
class home extends controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . path . '/login');
			die();
		}
		// getPermissions(1);
	}

	// Home view
	public function dashboard()
	{
		$data['page_tab'] = 'Dashboard';
		$data['page_favicon'] = 'favicon.ico';
		$data['page_title'] = 'Inicio';
		$data['page_breadcrumb'] = 'Inicio';
		$data['page_description'] = 'Dashboard';
		$data['page_icon'] = 'fa-solid fa-house-chimney';
		$data['page_link'] = path;
		$data['page_script'] = media . '/js/dashboard/dashboard.js';
		$data['page_actions'] = media . '/js/dashboard/actions.js';
		$this->views->getViews($this, "dashboard", $data);
	}

	// List of Knitting's SOP
	public function knitting()
	{
		$data['page_tab'] = 'Knitting SOP RN4';
		$data['page_favicon'] = 'favicon.ico';
		$data['page_title'] = 'Knitting';
		$data['page_breadcrumb'] = 'Knitting';
		$data['page_description'] = 'Auditoria SOP RN4';
		$data['page_icon'] = 'fa-solid fa-socks';
		$data['page_link'] = path;
		$data['page_script'] = media . '/js/knitting/knitting.js';
		$data['page_actions'] = media . '/js/knitting/actions.js';
		$this->views->getViews($this, "knitting", $data);
	}

	// List of Dyeing's SOP
	public function dyeing()
	{
		$data['page_tab'] = 'Dyeing SOP RN4';
		$data['page_favicon'] = 'favicon.ico';
		$data['page_title'] = 'Dyeing';
		$data['page_breadcrumb'] = 'Dyeing';
		$data['page_description'] = 'Auditoria SOP RN4';
		$data['page_icon'] = 'fa-solid fa-vial-circle-check';
		$data['page_link'] = path;
		$data['page_script'] = media . '/js/dyeing/dyeing.js';
		$data['page_actions'] = media . '/js/dyeing/actions.js';
		$this->views->getViews($this, "dyeing", $data);
	}

	// List of Boarding's SOP
	public function boarding()
	{
		$data['page_tab'] = 'Boarding SOP RN4';
		$data['page_favicon'] = 'favicon.ico';
		$data['page_title'] = 'Boarding';
		$data['page_breadcrumb'] = 'Boarding';
		$data['page_description'] = 'Auditoria SOP RN4';
		$data['page_icon'] = 'fa-solid fa-boxes-packing';
		$data['page_link'] = path;
		$data['page_script'] = media . '/js/boarding/boarding.js';
		$data['page_actions'] = media . '/js/boarding/actions.js';
		$this->views->getViews($this, "boarding", $data);
	}

	// List of Users
	public function users()
	{
		$data['page_tab'] = "Usuarios Registrados";
		$data['page_favicon'] = "favicon.ico";
		$data['page_title'] = "Listado de Usuarios";
		$data['page_breadcrumb'] = "Usuarios";
		$data['page_description'] = "Lista de usuarios de la empresa";
		$data['page_icon'] = "fa-solid fa-user-lock";
		$data['page_link'] = path;
		$data['page_script'] = media . "/js/users/users.js";
		$data['page_actions'] = media . '/js/users/actions.js';
		$this->views->getViews($this, "users", $data);
	}
}
