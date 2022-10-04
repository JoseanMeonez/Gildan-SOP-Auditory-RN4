<?php

class supervisor extends controllers {

	public function __construct()
	{
		parent::__construct();
	}

	public function getSupervisorOptions($supervisorId = 0)
	{
		$array_data = $this->model->getSupervisorOptions($supervisorId);
		$htmlOptions = "";
	
		// Setting all select's options
		if ($supervisorId == 0) {
			// Formatting options by default
			if (count($array_data) > 0) {
				for ($i = 0; $i < count($array_data); $i++) {
					$htmlOptions .= '<option value="'.$array_data[$i]['id'].'">' . $array_data[$i]['name'] . '</option>';
				}
			}
		} else {
			// Formatting options
			if (count($array_data) > 0) {
				for ($i = 0; $i < count($array_data); $i++) {
					if ($supervisorId == $array_data[$i]['id']) {
						$htmlOptions .= '<option selected value="'.$array_data[$i]['id'].'">' . $array_data[$i]['name'] . '</option>';
					} else {
						$htmlOptions .= '<option value="'.$array_data[$i]['id'].'">' . $array_data[$i]['name'] . '</option>';
					}
				}
			}
		}
	
		echo json_encode($htmlOptions, JSON_UNESCAPED_UNICODE);
		die;
	}
}