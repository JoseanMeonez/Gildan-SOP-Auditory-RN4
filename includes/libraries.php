<?php
function component(string $name, array $data)
{
	$componentName = "layout/$name.php";
	return require_once($componentName);
}

function dep($data)
{
	$format = print_r('<pre>');
	$format = print_r($data);
	$format = print_r('</pre>');

	return $format;
}

function getModal(string $nameModal, $data)
{
	$view_modal = "views/modals/{$nameModal}.phtml";
	return require_once($view_modal);
}

function getToasts()
{
	return require_once("views/toasts.phtml");
}

function getWeeks(int $month, int $year) {
	$dayend = cal_days_in_month(CAL_GREGORIAN,$month,$year);

	if ($month<10) {
		$add = "-0";
	} else { $add = "-"; }
	
	$date1 = $year.$add.$month."-01";
	$date2 = $year.$add.$month."-".$dayend;
	$weeks = date("W", strtotime($date2))-date("W", strtotime($date1)) + 1;
	return $weeks;
}

function uploadImage(array $data, string $name)
{
	$url_temp = $data['tmp_name'];
	$destination = 'assets/images/uploads/'.$name;
	$move = move_uploaded_file($url_temp, $destination);
	return $move;
}

function deleteFile(string $name){
	unlink('assets/images/uploads/' . $name);
}

function cleanString($string)
{
	$string = trim($string);
	$string = stripslashes($string);
	$string = str_ireplace("<script>", "", $string);
	$string = str_ireplace("</script>", "", $string);
	$string = str_ireplace("<script src>", "", $string);
	$string = str_ireplace("<script type>", "", $string);
	$string = str_ireplace("SELECT * FROM", "", $string);
	$string = str_ireplace("SELECT COUNT(*) FROM", "", $string);
	$string = str_ireplace("DELETE FROM", "", $string);
	$string = str_ireplace("DELETE * FROM", "", $string);
	$string = str_ireplace("INSERT INTO", "", $string);
	$string = str_ireplace("DROP TABLE", "", $string);
	$string = str_ireplace("DROP DATABASE", "", $string);
	$string = str_ireplace("TRUNCATE TABLE", "", $string);
	$string = str_ireplace("SHOW TABLES", "", $string);
	$string = str_ireplace("SHOW DATABASES", "", $string);
	$string = str_ireplace("<?php", "", $string);
	$string = str_ireplace("?>", "", $string);
	$string = str_ireplace("--", "", $string);
	$string = str_ireplace("{", "", $string);
	$string = str_ireplace("}", "", $string);
	$string = str_ireplace("[", "", $string);
	$string = str_ireplace("]", "", $string);
	$string = str_ireplace("^", "", $string);
	$string = str_ireplace("==", "", $string);
	$string = str_ireplace(";", "", $string);
	$string = str_ireplace("::", "", $string);
	$string = str_ireplace("OR '1'='1", "", $string);
	$string = str_ireplace('OR "1"="1"', "", $string);
	$string = str_ireplace('OR ´1´=´1´', "", $string);
	$string = str_ireplace("is NULL; --", "", $string);
	$string = str_ireplace("LIKE '", "", $string);
	$string = str_ireplace('LIKE "', "", $string);
	$string = str_ireplace("LIKE ´", "", $string);
	$string = str_ireplace("OR 'a'='a", "", $string);
	$string = str_ireplace('OR "a"="a', "", $string);
	$string = str_ireplace("OR ´a´=´a", "", $string);
	$string = str_ireplace("", "", $string);
	$string = str_ireplace("", "", $string);
	$string = str_ireplace("", "", $string);
	$string = str_ireplace("", "", $string);
	$string = stripslashes($string);
	$string = trim($string);
	return $string;
}

function passGenerator($length = 10)
{
	$password = "";
	$passwordLength = $length;
	$string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
	$stringLength = strlen($string);

	for ($i = 1; $i <= $passwordLength; $i++) {
		$pos = rand(0, $stringLength - 1);
		$password .= substr($string, $pos, 1);
	}
	return $password;
}