(function () {
	'use strict';

	let treeviewMenu = $('.app-menu');

	/* <----- Toggle Sidebar -----> */
	$('[data-bs-toggle="sidebar"]').click(function (e) {
		e.preventDefault();
		$('.app').toggleClass('sidenav-toggled');
	});

	/* <----- Activate sidebar treeview toggle -----> */
	$('[data-bs-toggle="treeview"]').click(function (e) {
		e.preventDefault();
		if (!$(this).parent().hasClass('is-expanded')) {
			treeviewMenu.find('[data-bs-toggle="treeview"]').parent().removeClass('is-expanded');
		}
		$(this).parent().toggleClass('is-expanded');
	});

	/* <----- Set initial active toggle -----> */
	$('[data-bs-toggle="treeview"].is-expanded').parent().toggleClass('is-expanded');

	/* <----- Activate bootstrip tooltips -----> */
	// $("[data-bs-toggle='tooltip']").tooltip();
})();