export const DataTableFilter = $('#tblRoles thead tr').clone(true).addClass('filters').appendTo('#tblRoles thead');

export const DataTable = () => $('#tblRoles').DataTable({
	'language': {
		'url': 'assets/json/es.json',
	},
	'dom': 'lBfrtip',
	'lengthMenu': [
		[10, 25, 50, 100, -1],
		[10 + " Registros", 25 + " Registros", 50 + " Registros", 100 + " Registros", "Mostrar Todos"]
	],
	'buttons': [
		// Copy Button
		{
			'extend': 'copyHtml5',
			'text': '<i class="fa-regular fa-copy fa-lg"></i>',
			'title': 'Listado de roles',
			'titleAttr': 'Copiar',
			'className': 'btn btnCopy btn-sm',
			'exportOptions': {
				'columns': [0, 1, 2, 3]
			}
		},
		// Button export to Excel
		{
			'extend': 'excelHtml5',
			'text': '<i class="fa-regular fa-file-excel fa-lg"></i>',
			'title': 'Listado de roles',
			'titleAttr': 'Excel',
			'className': 'btn btnExcel btn-sm',
			'exportOptions': {
				'columns': [0, 1, 2, 3]
			}
		},
		// Button Create a PDF File
		{
			'extend': 'pdfHtml5',
			'text': '<i class="fa-regular fa-file-pdf fa-lg"></i>',
			'title': 'Listado de roles',
			'titleAttr': 'PDF',
			'className': 'btn btnPDF btn-sm',
			'exportOptions': {
				'columns': [0, 1, 2, 3]
			}
		},
		// Button Print
		{
			'extend': 'print',
			'text': '<i class="fa-solid fa-print fa-lg"></i>',
			'title': '<p class="text-center">Listado de roles</p>',
			'titleAttr': 'Imprimir',
			'className': 'btn btnPrint btn-sm',
			'exportOptions': {
				'columns': [0, 1, 2, 3]
			}
		},
		// Button to open a Modal
		{
			'action': function () {
				document.querySelector('#txtid').value = "";
				$('.modal-header').css('background-color', '#0d6efd');
				$('.modal-header').css('color', '#ffffff');
				$('.modal-title').text('Agregar Rol')
				$('.cancelButton').css('background-color', "#6C757D");
				$('.cancelButton').css('color', "#ffffff");
				$('.cancelButton').text('Cancelar');
				$('.actionButton').css('background-color', "#0d6efd");
				$('.actionButton').css('color', "#ffffff");
				$('.actionButton').text('Guardar');
				document.getElementById('frmRoles').reset();
				modalX.modal('show');

				var mdlRoles = document.getElementById('mdlRoles')
				var nameFocus = document.getElementById('txtname')

				mdlRoles.addEventListener('shown.bs.modal', function () {
					nameFocus.focus()
				});
			},
			'text': '<i class="fa-solid fa-circle-plus fa-lg"></i> Nuevo',
			'titleAttr': 'Agregar Nuevo Rol',
			'className': 'btn btnNew btn-sm'
		}
	],
	"ajax": {
		"url": server + '/roles/selectall',
		"dataSrc": ''
	},
	"columns": [
		{ 'type': 'html-num', 'data': 'id' },
		{ 'data': 'name' },
		{ 'data': 'description' },
		{ 'data': 'created' },
		{ 'data': 'status' },
		{ 'data': 'options' }
	],
	"bDestroy": true,
	"iDisplayLength": 10,
	"order": [[0, "desc"]],
	"orderCellsTop": true,
	"fixedHeader": true,
	initComplete: function () {
		var api = this.api();
		// For each column
		api.columns().eq(0).each(function (colIdx) {
			// Set the header cell to contain the input element
			var cell = $('.filters th').eq($(api.column(colIdx).header()).index());
			var title = $(cell).text();
			$(cell).html('<input class="form form-control text-center frmDT" type="text" placeholder="' + title + '"/>');
			// On every keypress in this input
			$('input', $('.filters th').eq($(api.column(colIdx).header()).index()))
				.off('keyup change')
				.on('keyup change', function (e) {
					e.stopPropagation();
					// Get the search value
					$(this).attr('title', $(this).val());
					var regexr = '({search})'; //$(this).parents('th').find('select').val();
					var cursorPosition = this.selectionStart;
					// Search the column for that value
					api
						.column(colIdx)
						.search((this.value != "") ? regexr.replace('{search}', '(((' + this.value + ')))') : "", this.value != "", this.value == "")
						.draw();
					$(this).focus()[0].setSelectionRange(cursorPosition, cursorPosition);
				});
		});
	},
	"responsive": {
		"details": {
			"display": $.fn.dataTable.Responsive.display.modal({
				"header": function (row) {
					var data = row.data();
					return info;
				}
			}),
			"renderer": $.fn.dataTable.Responsive.renderer.tableAll()
		}
	}
});