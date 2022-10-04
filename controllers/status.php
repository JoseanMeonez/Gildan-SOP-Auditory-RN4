<?php
class status extends controllers
{
	public function __construct()
	{
		parent::__construct();
		session_start();
		if (empty($_SESSION['login'])) {
			header('Location: ' . path . '/login');
			die();
		}
	}

	public function getStatus()
	{
		$htmlOptions = "";
		$adata = $this->model->getStatus();

		if (count($adata) > 0) {
			$htmlOptions .= '<option value="0" selected disabled>Seleccione...</option>';
			for ($i = 0; $i < count($adata); $i++) {
				if ($adata[$i]['stt_status'] == 1) {
					$htmlOptions .= '<option value="' . $adata[$i]['stt_id'] . '">' . $adata[$i]['stt_name'] . '</option>';
				}
			}
		}

		echo $htmlOptions;
		die();
	}

	public function getStatusRRHH()
	{

		$htmlOptions = "";
		$adata = $this->model->getStatusRRHH();

		if (count($adata) > 0) {
			$htmlOptions .= '<option selected disabled>Seleccione...</option>';
			for ($i = 0; $i < count($adata); $i++) {
				if ($adata[$i]['stt_status'] == 1) {
					$htmlOptions .= '<option value="' . $adata[$i]['stt_id'] . '">' . $adata[$i]['stt_name'] . '</option>';
				}
			}
		}

		echo $htmlOptions;
		die();
	}
}
