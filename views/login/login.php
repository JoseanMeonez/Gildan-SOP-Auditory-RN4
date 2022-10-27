<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="theme-color" content="#0039b3">
	
	<!-- iOS support -->
	<meta name="apple-mobile-web-app-status-bar" content="#0039b3">
	
	<!-- Manifest and title -->
	<link rel="manifest" href="<?= path ?>/manifest.json">
	<title><?= $data['page_title']; ?></title>
	<!-- Favicon -->
	<link rel="shortcut icon" href="<?= media; ?>/images/icons/<?= $data['page_favicon']; ?>" type="image/x-icon">
	<!-- Bootstrap -->
	<link rel="stylesheet" href="<?= vendors; ?>/bootstrap/css/bootstrap.min.css">
	<!-- Font-icon css-->
	<link rel="stylesheet" href="<?= vendors; ?>/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="<?= vendors; ?>/fontawesome/css/fontawesome.min.css">
	<!-- Pace -->
	<link rel="stylesheet" href="<?= vendors; ?>/pace/themes/blue/pace-theme-minimal.css">
	<!-- Toastr -->
	<link rel="stylesheet" href="<?= vendors; ?>/toastr/build/toastr.min.css">
	<!-- SweetAlert 2 -->
	<link rel="stylesheet" href="<?= vendors; ?>/sweetalert2/css/sweetalert2.min.css">
	<!-- Main CSS-->
	<link rel="stylesheet" href="<?= media; ?>/css/style.css">
	<link rel="stylesheet" href="<?= media; ?>/css/main.css">
</head>

<body class="loginByte">
	<section class="login-content">
		<div class="login-box">
			<div id="divLoading">
				<div>
					<img src="<?= media; ?>/images/loading.svg" alt="Cargando">
				</div>
			</div>
			<!-- Formulario de Inicio de Sesión -->
			<form class="login-form text-center" id="frmLogin" name="frmLogin">
				<div class="logo">
					<a href="<?= path; ?>/login">
						<img class="logo_image" src="<?= media; ?>/images/logo2.png" alt="Logo de la empresa">
					</a>
				</div>
				<h3 class="login-head mb-5">
					<i class="icoLogin fa-solid fa-user-lock fa-xl fa-fw"></i> &nbsp;&nbsp;&nbsp;
					<span>INGENIERIA RN3 - RN4</span>
				</h3>
				<div class="form-group form_info mb-5">
					<input type="text" id="txtusername" name="txtusername" class="form-control form_input2" placeholder=" " autofocus autocomplete="new-password">
					<label for="txtusername" class="form-label form_label2">Usuario</label>
				</div>
				<div class="form-group form_info mb-3">
					<input type="password" id="txtpassword" name="txtpassword" class="form-control form_input2" placeholder=" " autocomplete="new-password">
					<label for="txtpassword" class="form-label form_label2">Contraseña</label>
				</div>
				<div class="form-group modal-footer justify-content-center">
					<button class="btn button-login btn-success">
						<i class="fa-solid fa-right-to-bracket fa-xl fa-fw"></i>
						<span>Iniciar Sesión</span>
					</button>
				</div>
				<img class="ing-logo" src="<?= media; ?>/images/Ing.png">
			</form>
		</div>
	</section>
	<!-- Essential javascripts for application to work-->
	<script>
		const server = '<?= path; ?>'
	</script>
	<script src="<?= vendors; ?>/jquery/jquery.min.js"></script>
	<script src="<?= vendors; ?>/popper/popper.min.js"></script>
	<script src="<?= vendors; ?>/bootstrap/js/bootstrap.min.js"></script>
	<script src="<?= vendors; ?>/fontawesome/js/fontawesome.min.js"></script>
	<script src="<?= vendors; ?>/pace/pace.min.js"></script>
	<script src="<?= vendors; ?>/toastr/build/toastr.min.js"></script>
	<script src="<?= vendors; ?>/sweetalert2/js/sweetalert2.min.js"></script>
	<script src="<?= $data['page_script']; ?>"></script>
</body>

</html>