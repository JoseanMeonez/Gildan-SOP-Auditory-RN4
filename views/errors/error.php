<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<title>Página no encontrada</title>
	<link rel="shortcut icon" href="<?= media; ?>/images/error.ico" type="image/x-icon">
	<link rel="stylesheet" href="<?= vendors; ?>/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<?= vendors; ?>/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="<?= vendors; ?>/fontawesome/css/fontawesome.min.css">
	<link rel="stylesheet" href="<?= media; ?>/css/style.css">
</head>

<body class="d-flex justify-content-center bg-warning">

	<div class="container shadow rounded m-5 p-5 error bg-white">
		<div class="row">
			<div class="col text-center">
				<img class="error_img" src="<?= media; ?>/images/error.png" width="200px">
			</div>
			<div class="col align-self-center">
				<h4 class="error_title">
					<i class="fa-solid fa-globe fa-lg" style="color: red;"></i> &nbsp;&nbsp;&nbsp;&nbsp; 404 (Página no encontrada)
				</h4>
				<p class="error_body">No fue posible encontrar la página solicitada, esto se debe posiblemente a que el directorio fue movido por el administrador o no existe la dirección buscada.</p>
				<p>
					<a class="btn btn-warning btnerror fa-lg" href="javascript:window.history.back();">
						<i class="fa-solid fa-triangle-exclamation"></i> Regresar
					</a>
				</p>
			</div>
		</div>
	</div>

	<script src="<?= vendors; ?>/jquery/jquery.min.js"></script>
	<script src="<?= vendors; ?>/popper/popper.min.js"></script>
	<script src="<?= vendors; ?>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<?= vendors; ?>/fontawesome/js/all.min.js"></script>
	<script src="<?= vendors; ?>/fontawesome/js/fontawesome.min.js"></script>
</body>

</html>