<?php
class controllers
{
	// Instantiating the views object
	public function __construct()
	{
		$this->views = new views();
		$this->loadModel();
	}

	// Load the model of the view charged
	public function loadModel()
	{
		$model = get_class($this) . "Model";
		$path_class = "models/" . $model . ".php";

		if (file_exists($path_class)) {
			require_once($path_class);
			$this->model = new $model();
		}
	}
}
