<?php
require_once('includes/env.php');
require_once('includes/libraries.php');

$url = !empty($_GET['bytes']) ? $_GET['bytes'] : 'home/dashboard';
$url_array = explode('/', $url);
$controller = $url_array[0];
$method = $url_array[0];
$params = "";

if (!empty($url_array[1])) {
	if ($url_array[1] != "") {
		$method = $url_array[1];
	}
}

if (!empty($url_array[2])) {
	if ($url_array[2] != "") {
		for ($i = 2; $i < count($url_array); $i++) {
			$params .= $url_array[$i] . ',';
		}
		$params = trim($params, ',');
	}
}

require_once("includes/autoload.php");
require_once("includes/load.php");
