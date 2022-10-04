<?php
class views
{
	function getViews($controller, $view, $data = "")
	{
		$controller = get_class($controller);

		if ($controller == "home") {
			$view = "views/" . $view . ".php";
		} else {
			$view = "views/" . $controller . "/" . $view . ".php";
		}

		require_once($view);
	}
}
