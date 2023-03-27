<?php

class dashboard extends controllers
{
	public function __construct()
	{
		parent::__construct();
	}

	public function getAllAuditDetails()
	{
		$area = intval($_GET['area']);
		$year = intval($_GET['year']);
		$month = intval($_GET['month']);
		$week = intval($_GET['week']);
		$meses = array('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre');

		if ($area == 0 or $year == 0 or $month == 0 or $week == 0) {
			$req = $this->model->getAllAuditsDetail();
			for ($i = 0; $i < count($req); $i++) {
				$req[$i]['Resultado'] = round(100 * $req[$i]['Resultado'], 2) . "%";
				$req[$i]['Mes'] = $meses[($req[$i]['Mes'] - 1)];
				$req[$i]['Posicion_Desglosada'] = $req[$i]['Posicion_Desc'].' - Semana '.$req[$i]['Semana'];
			}
		} else {
			$req = $this->model->getAuditDetail($area, $year, $month, $week);
			for ($i = 0; $i < count($req); $i++) {
				$req[$i]['Resultado'] = round(100 * $req[$i]['Resultado'], 2) . "%";
				$req[$i]['Mes'] = $meses[($req[$i]['Mes'] - 1)];
				$req[$i]['Posicion_Desglosada'] = $req[$i]['Posicion_Desc'].' - Semana '.$req[$i]['Semana'];
			}
		}

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}
}