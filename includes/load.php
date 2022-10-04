<?php
$controller_file = "controllers/" . $controller . ".php";

// Verifying if the controller exists and his method
if (file_exists($controller_file)) {
	require_once($controller_file);

	// While the controller is the logout object just will execute the construct method
	if ($controller == 'logout') {
		$controller = new $controller();
	} else {
		if (method_exists($controller, $method)) {
			$controller = new $controller();
			$controller->{$method}($params);
		} else {
			require_once("controllers/error.php");
		}
	}
} else {
	require_once("controllers/error.php");
}
