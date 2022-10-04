	<!-- Libraries -->
	<!-- Jquery, Popper & Bootstrap -->
	<script type="text/javascript" src="<?= vendors; ?>/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/popper/popper.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/bootstrap/js/bootstrap.min.js"></script>

	<!-- Datatables -->
	<script type="text/javascript" src="<?= vendors; ?>/jszip/jszip.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/pdfmake/pdfmake.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/pdfmake/vfs_fonts.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/datatables/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/datatables/js/dataTables.bootstrap5.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/buttons/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/buttons/js/buttons.bootstrap5.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/buttons/js/buttons.colVis.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/buttons/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/buttons/js/buttons.print.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/datetime/js/dataTables.dateTime.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/responsive/js/dataTables.responsive.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/responsive/js/responsive.bootstrap5.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/rowgroup/js/dataTables.rowGroup.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/rowreorder/js/dataTables.rowReorder.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/searchbuilder/js/dataTables.searchBuilder.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/searchbuilder/js/searchBuilder.bootstrap5.min.js"></script>

	<!-- Fontawesome scripts -->
	<script type="text/javascript" src="<?= vendors; ?>/fontawesome/js/all.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/fontawesome/js/fontawesome.min.js"></script>

	<!-- Sweet alert & Pace -->
	<script type="text/javascript" src="<?= vendors; ?>/sweetalert2/js/sweetalert2.all.min.js"></script>
	<script type="text/javascript" src="<?= vendors; ?>/pace/pace.min.js"></script>

	<!-- ENV -->
	<script>
		const company = '<?= company; ?>';
		const server = '<?= path; ?>';
	</script>

	<!-- Customize Javascript Files -->
	<script type="text/javascript" src="<?= media; ?>/js/main.js"></script>
	<script type="text/javascript" src="<?= media; ?>/js/toast.js"></script>

	<!-- Page Scripts -->
	<script type="module" src="<?= $data['page_script']; ?>"></script>
	<script type="text/javascript" src="<?= $data['page_actions']; ?>"></script>
	</body>

</html>