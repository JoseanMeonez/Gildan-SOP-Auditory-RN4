<!DOCTYPE html>
<html lang="es">

<head>
	<!-- Metadata -->
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="theme-color" content="#0039b3">
	
	<!-- iOS support -->
	<meta name="apple-mobile-web-app-status-bar" content="#0039b3">
	
	<!-- Manifest and title -->
	<link rel="manifest" href="<?= path ?>/manifest.json">
	<title><?= $data['page_tab']; ?></title>
	<link rel="shortcut icon" type="image/x-icon" href="<?= media; ?>/images/<?= $data['page_favicon']; ?>">

	<!-- Bootstrap -->
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/bootstrap/css/bootstrap.min.css">
	
	<!-- Datatables -->
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/datatables/css/dataTables.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/fixedheader/css/fixedHeader.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/autofill/css/autoFill.bootstrap5.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/buttons/css/buttons.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/colreorder/css/colReorder.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/datetime/css/dataTables.dateTime.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/responsive/css/responsive.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/rowgroup/css/rowGroup.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/rowreorder/css/rowReorder.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/searchbuilder/css/searchBuilder.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/searchpanes/css/searchPanes.bootstrap5.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/select/css/select.bootstrap5.min.css">
	
	<!-- Fontawesome -->
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/fontawesome/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/fontawesome/css/fontawesome.min.css">

	<!-- SweetAlert -->
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/sweetalert2/css/sweetalert2.min.css">
	
	<!-- Pace Themes -->
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/pace/pace-theme-default.min.css">
	<link rel="stylesheet" type="text/css" href="<?= vendors; ?>/pace/themes/blue/pace-theme-minimal.css">

	<!-- Own Styles and fonts -->
	<!-- <link rel="stylesheet" type="text/css" href="<?= media; ?>/css/inter-font.css">
	<link rel="stylesheet" type="text/css" href="<?= media; ?>/css/public-sans-font.css"> -->
	<link rel="stylesheet" type="text/css" href="<?= media; ?>/css/style.css">
	<link rel="stylesheet" type="text/css" href="<?= media; ?>/css/main.css">
</head>

<body class="app sidebar-mini">
	<!-- Header -->
	<header class="app-header">
		
		<!-- Brand & Logo -->
		<a class="app-header__brand" href="<?= path; ?>">
			<img class="app-header__logo" src="<?= media; ?>/images/logo.svg" alt="Company Logo">
		</a>

		<!-- Toggle Button -->
		<a class="app-sidebar__toggle" href="#" data-bs-toggle="sidebar" aria-label="Hide Sidebar">
			<i class="fa-solid fa-bars"></i>
		</a>
		
		<!-- Navbar -->
		<ul class="app-nav">

			<!-- Search input -->
			<li class="app-search">
				<input class="app-search__input" type="search" placeholder="Buscar">
				<button class="app-search__button">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</li>

			<!-- Notifications -->
			<li class="dropdown">
				<a class="app-nav__item" href="#" data-bs-toggle="dropdown" aria-label="Show notifications">
					<i class="app-nav__item_icon fa-solid fa-bell fa-lg"></i>
				</a>
				<ul class="app-notification dropdown-menu dropdown-menu-right">
					<li class="app-notification__title">You have 3 new notifications.</li>
					<div class="app-notification__content">
							<li>
								<a class="app-notification__item" href="javascript:;">
									<span class="app-notification__icon">
										<span class="fa-stack fa-xl">
											<i class="fa-solid fa-circle fa-stack text-primary"></i>
											<i class="fa-solid fa-envelope fa-stack-1x fa-inverse"></i>
										</span>
									</span>
									<div>
										<p class="app-notification__message">Lisa sent you a mail</p>
										<p class="app-notification__meta">2 min ago</p>
									</div>
								</a>
							</li>
							<li>
								<a class="app-notification__item" href="javascript:;">
									<span class="app-notification__icon">
										<span class="fa-stack fa-xl">
											<i class="fa-solid fa-circle fa-stack text-danger"></i>
											<i class="fa-solid fa-hard-drive fa-stack-1x fa-inverse"></i>
										</span>
									</span>
									<div>
										<p class="app-notification__message">Mail server not working</p>
										<p class="app-notification__meta">5 min ago</p>
									</div>
								</a>
							</li>
							<li>
								<a class="app-notification__item" href="javascript:;">
									<span class="app-notification__icon">
										<span class="fa-stack fa-xl">
											<i class="fa-solid fa-circle fa-stack text-success"></i>
											<i class="fa-solid fa-sack-dollar fa-stack-1x fa-inverse"></i>
										</span>
									</span>
									<div>
										<p class="app-notification__message">Transaction complete</p>
										<p class="app-notification__meta">2 days ago</p>
									</div>
								</a>
							</li>
					</div>
					<li class="app-notification__footer">
						<a class="app-notification__footer_label" href="#">See all notifications.</a>
					</li>
				</ul>
			</li>

			<!-- User Menu -->
			<li class="dropdown">
				<a class="app-nav__item" href="#" data-bs-toggle="dropdown" aria-label="Open Profile Menu">
					<i class="app-nav__item_icon fa fa-user fa-lg"></i>
				</a>
				<ul class="dropdown-menu settings-menu dropdown-menu-right">
					<li>
						<a class="dropdown-item" href="">
							<i class="dropdown-item__icon fa-solid fa-gears fa-lg"></i>&nbsp;&nbsp;
							<span class="dropdown-item__label">Ajustes de la aplicación</span>
						</a>
					</li>
					<li>
						<a class="dropdown-item" href="">
							<i class="dropdown-item__icon fa-solid fa-id-card fa-lg"></i>&nbsp;&nbsp;
							<span class="dropdown-item__label">Perfil del usuario</span>
						</a>
					</li>
					<li>
						<hr class="dropdown-divider">
					</li>
					<li>
						<a class="dropdown-item" href="<?= path; ?>/logout">
							<i class="dropdown-item__icon fa-solid fa-power-off fa-lg"></i>&nbsp;&nbsp;
							<span class="dropdown-item__label">Cerrar Sesión</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
	</header>

	<?= component('sidebar', $data); ?>