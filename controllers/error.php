<?php
class errors extends controllers
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

	public function notfound()
	{
		$this->views->getViews($this, "error");
	}
}

$notfound = new errors();
$notfound->notfound();
