<?php
class logout
{
	public function __construct()
	{
		session_start();
		session_unset();
		session_destroy();
		header('Location: ' . path . '/login');
		die();
	}
}
