import { setComboBox } from "../positions/functions.js"
// Datatable's filters
export const datatableFilter = (table) => $('#'+ table +' thead tr').clone(true).addClass('filters').appendTo('#'+ table +' thead')

// Datatable properties
export const boarding = () => $('#table-boarding').DataTable({
	language: { url: server + '/assets/json/spanish.json' },
	dom: 'lBfrtip',
	lengthMenu: [
		[10, 25, 50, 100, -1],
		[
			10 + " Registros",
			25 + " Registros",
			50 + " Registros",
			100 + " Registros",
			"Mostrar Todos"
		]
	],
	ajax: {
		url: server + '/points/getBoardingPoints',
		dataSrc: ''
	},
	columns: [
		{
			type: 'html-num',
			data: 'id'
		},
		{ data: 'area' },
		{ data: 'posicion' },
		{ data: 'punto' },
		{ data: 'descripcion' },
		{ data: 'acciones' },
	],
	buttons: [
		// Copy Button
		{
			extend: 'copyHtml5',
			text: '<i class="fa-regular fa-copy fa-lg"></i>',
			title: 'Listado de puntos Boarding',
			titleAttr: 'Copiar',
			className: 'btn btnCopy btn-sm',
			exportOptions: {
				columns: [1, 2, 3, 4]
			}
		},
		// Button export to Excel
		{
			customize: function (window) {

			},
			extend: 'excelHtml5',
			text: '<i class="fa-regular fa-file-excel fa-lg"></i>',
			title: 'Listado de puntos Boarding',
			titleAttr: 'Excel',
			className: 'btn btnExcel btn-sm',
			exportOptions: {
				columns: [1, 2, 3, 4]
			}
		},
		// Button Create a PDF File
		{
			customize: function (window) {

			},
			extend: 'pdfHtml5',
			text: '<i class="fa-regular fa-file-pdf fa-lg"></i>',
			title: 'Listado de puntos Boarding',
			titleAttr: 'PDF',
			className: 'btn btnPDF btn-sm',
			exportOptions: {
				columns: [1, 2, 3, 4]
			}
		},
		// Button Print
		{
			customize: function (window) {

			},
			extend: 'print',
			text: '<i class="fa-solid fa-print fa-lg"></i>',
			titleAttr: 'Imprimir',
			className: 'btn btnPrint btn-sm',
			exportOptions: {
				columns: [1, 2, 3, 4]
			}
		},
		// Button to open a Modal
		{
			action: function () {
				setComboBox(0,2,true,"#posicion")
				$('#punto').val('');
				$('#descripcion').val('');
				
				$('.modal-title').text("Crear Punto de Auditoria Boarding")
				$('.modal-content').removeClass('bg-orangered')
				$('.modal-content').addClass('bg-primary')
				$('#pointsModal').modal('show')
			},
			text: '<i class="fa-solid fa-plus fa-lg"></i> Nuevo',
			titleAttr: 'Agregar nuevo punto',
			className: 'btn btnNew btn-sm'
		}
	],
	bDestroy: true,
	iDisplayLength: 10,
	order: [
		[0, "asc"]
	],
	orderCellsTop: true,
	fixedHeader: true,
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
	responsive: {
		details: {
			display: $.fn.dataTable.Responsive.display.modal({
				header: function (row) {
					var data = row.data();
					return "Punto de Auditoria";
				}
			}),
			renderer: $.fn.dataTable.Responsive.renderer.tableAll()
		}
	}
});