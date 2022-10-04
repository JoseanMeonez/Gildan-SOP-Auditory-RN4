<?php
spl_autoload_register(function ($class) {
	if (file_exists("includes/" . $class . ".php")) {
		require_once("includes/" . $class . ".php");
	}
});
