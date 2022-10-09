<?php

class positions extends controllers
{
	public function __construct()
	{
		parent::__construct();
	}

	public function setComboBox()
	{
		$id = cleanstring(intval($_GET['id']));
		$area = cleanstring(intval($_GET['area']));
		$arr = $this->model->getComboBoxData($area);
		$comboBox = "";
	
		// Setting all select's options
		if ($id == 0) {
			// Formatting options by default
			if (count($arr) > 0) {
				for ($i = 0; $i < count($arr); $i++) {
					$comboBox .= '<option value="'.$arr[$i]['id'].'">' . $arr[$i]['descr'] . '</option>';
				}
			}
		} else {
			// Formatting options
			if (count($arr) > 0) {
				for ($i = 0; $i < count($arr); $i++) {
					if ($id == $arr[$i]['id']) {
						$comboBox .= '<option selected value="'.$arr[$i]['id'].'">' . $arr[$i]['descr'] . '</option>';
					} else {
						$comboBox .= '<option value="'.$arr[$i]['id'].'">' . $arr[$i]['descr'] . '</option>';
					}
				}
			}
		}
	
		echo json_encode($comboBox, JSON_UNESCAPED_UNICODE);
		die;
	}
}