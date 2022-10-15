import { getSupervisorOption } from '../supervisor/functions.js'
import { setComboBox } from "../positions/functions.js";

// Datatable's filters
export const datatableFilter = () => $('#tblBoarding thead tr').clone(true).addClass('filters').appendTo('#tblBoarding thead')

// Datatable properties
export const datatable = () => $('#tblBoarding').DataTable({
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
		url: server + '/Boarding/getAudits',
		dataSrc: ''
	},
	columns: [
		{
			type: 'html-num',
			data: 'Id_Auditoria'
		},
		{ data: 'Fecha' },
		{ data: 'Semana' },
		{ data: 'Mes' },
		{ data: 'Area_Nombre' },
		{ data: 'Pasa' },
		{ data: 'Falla' },
		{ data: 'Resultado' },
		{ data: 'editar'}
	],
	buttons: [
		// Copy Button
		{
			extend: 'copyHtml5',
			text: '<i class="fa-regular fa-copy fa-lg"></i>',
			title: 'Listado de usuarios',
			titleAttr: 'Copiar',
			className: 'btn btnCopy btn-sm',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 6, 7]
			}
		},
		// Button export to Excel
		{
			customize: function (window) {

			},
			extend: 'excelHtml5',
			text: '<i class="fa-regular fa-file-excel fa-lg"></i>',
			title: 'Listado de usuarios',
			titleAttr: 'Excel',
			className: 'btn btnExcel btn-sm',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 6, 7]
			}
		},
		// Button Create a PDF File
		{
			customize: function (window) {

			},
			extend: 'pdfHtml5',
			text: '<i class="fa-regular fa-file-pdf fa-lg"></i>',
			title: 'Listado de usuarios',
			titleAttr: 'PDF',
			className: 'btn btnPDF btn-sm',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 6, 7]
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
				columns: [0, 1, 2, 3, 4, 6, 7]
			}
		},
		// Button to open a Modal
		{
			action: function () {
				detailTable(1)
				setComboBox(0,2,false,"#posicion")
				getSupervisorOption("#supervisor")
				$('#addAuditBoarding').modal('show');
			},
			text: '<i class="fa-solid fa-plus fa-lg"></i> Nuevo',
			titleAttr: 'Agregar nueva auditoria',
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
					return "Auditoria de la semana " + data.Semana + " del mes de " + data.Mes;
				}
			}),
			renderer: $.fn.dataTable.Responsive.renderer.tableAll()
		}
	}
});


// Detail Datatable properties
export const detailTable = (id) => $('#detalleAuditoria').DataTable({
	'language': {
		'url': server + '/assets/json/spanish.json',
	},
	'dom': 'lfrtip',
	'lengthMenu': [
		[10, 25, 50, -1],
		["10 Registros", "25 Registros", "50 Registros", "Mostrar Todos"]
	],
	"ajax": {
		"url": server + '/Boarding/getAuditDetail',
		"data": { id: id },
		"dataSrc": ''
	},
	"columns": [
		{'data': 'posicion_desc'},
		{'data': 'punto'},
		{'data': 'punto_desc'},
		{'data': 'Acciones'}
	],
	"bDestroy": true,
	"iDisplayLength": 10,
	"order": [
		[1, "asc"]
	],
	"orderCellsTop": true,
	"fixedHeader": true,
	"responsive": {
		"details": {
			"display": $.fn.dataTable.Responsive.display.modal({
				"header": function (row) {
					var data = row.data();
					return 'Detalle de la Auditoria';
				}
			}),
			"renderer": $.fn.dataTable.Responsive.renderer.tableAll()
		}
	}
});