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
				$req[$i]['Posicion_Desglosada'] = $req[$i]['Posicion_Desc'];
			}
		}

		echo json_encode($req, JSON_UNESCAPED_UNICODE);
		die;
	}

	public function getYearOptions()
	{
		$area = intval($_GET['area']);
		$res = $this->model->getYearOptions($area);
		$htmlOptions = "";
	
		// Formatting options by default
		if (count($res) > 0) {
			for ($i = 0; $i < count($res); $i++) {
				$htmlOptions .= '<option value="'.$res[$i]['Año'].'">' . $res[$i]['Año'] . '</option>';
			}
		}

		echo json_encode($htmlOptions, JSON_UNESCAPED_UNICODE);
		die;
	}

	public function getMonthOptions()
	{
		$area = intval($_GET['area']);
		$year = intval($_GET['year']);
		$res = $this->model->getMonthOptions($area, $year);
		$htmlOptions = "";
		$meses = array('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre');
	
		// Formatting options by default
		if (count($res) > 0) {
			for ($i = 0; $i < count($res); $i++) {
				$htmlOptions .= '<option value="'.$res[$i]['Mes'].'">' . $meses[$res[$i]['Mes']-1] . '</option>';
			}
		}

		echo json_encode($htmlOptions, JSON_UNESCAPED_UNICODE);
		die;
	}

	public function getWeekOptions()
	{
		$area = intval($_GET['area']);
		$year = intval($_GET['year']);
		$month = intval($_GET['month']);
		$res = $this->model->getWeekOptions($area, $year, $month);
		$htmlOptions = "";
	
		// Formatting options by default
		if (count($res) > 0) {
			for ($i = 0; $i < count($res); $i++) {
				$htmlOptions .= '<option value="'.$res[$i]['Semana'].'">' . $res[$i]['Semana'] . '</option>';
			}
		}

		echo json_encode($htmlOptions, JSON_UNESCAPED_UNICODE);
		die;
	}
}