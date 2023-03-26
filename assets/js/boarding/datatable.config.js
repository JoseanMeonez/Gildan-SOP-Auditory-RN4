import { getSupervisorOption } from '../supervisor/functions.js'
import { setComboBox } from "../positions/functions.js";

// Datatable's filters
export const datatableFilter = () => $('#tblBoarding thead tr').clone(true).addClass('filters').appendTo('#tblBoarding thead')

export function seeAuditModal() {
	// Load the Visualization API and the corechart package.
	google.charts.load('current', {
		'packages': ['corechart']
	});
	
	$(document).on("click", ".seeAudit", function () {
		// Hidding the responsive data modal
		$(".dtr-bs-modal").modal('hide')
		let dataid = this.getAttribute('dataid')
		finalDetail(dataid)

		google.charts.setOnLoadCallback(() => {
			$.ajax({
				type: "get",
				url: server + "/boarding/getPassedAuditsDetails",
				data: { id: dataid },
				success: (r) => {
					let res = JSON.parse(r)

					// Creating Date format
					const date = new Date(2023, res[0].Mes - 1);

					// Obtaining the month name based on the previous format
					const monthName = date.toLocaleString('es-ES', { month: 'long' });
					const month = monthName.charAt(0).toUpperCase() + monthName.slice(1);

					var data = new google.visualization.DataTable();
					data.addColumn('string', 'Topping');
					data.addColumn('number', 'Slices');

					for (let i = 0; i < res.length; i++) {
						// Adding every data
						data.addRows([
							[res[i].Posicion_Desc, parseInt(res[i].Puntos_Fallados)]
						]);
					}

					// Set chart options
					let options = {
						title: `Puntos que Pasan la Auditoria de la Semana ${res[0].Semana} de ${month}`,
						titleTextStyle: { fontSize: 20 },
						width: 800,
						height: 400,
						fontName: "Poppins",
						fontSize: 12,
						legend: {
							textStyle: {
								fontSize: 12,
								bold: true,
							},
							position: "right"
						},
						chartArea: { left: 0, top: 50, width: '100%', height: '80%' },
						pieSliceTextStyle: {
							color: 'black',
							fontSize: 12,
							bold: true
						},
						slices: {
							0: { offset: 0.02 },
							1: { offset: 0.02 },
							2: { offset: 0.02 },
							3: { offset: 0.02 },
							4: { offset: 0.02 },
							5: { offset: 0.02 },
						},
						// colors: ["#6ab04c", "#7fc77e", "#9bd5b2", "#b5e3d5", "#c5ecd9"],
						// is3D: true,
						pieStartAngle: 45
					}

					// Instantiate and draw our chart, passing in some options.
					var chart = new google.visualization.PieChart(document.getElementById('chart_div'))
					return chart.draw(data, options)
				}
			})
		})
		
		$('#seeAuditBoarding').modal('show');
		$(document).on("click", "#printChart", function () {
			printChart()
		})
	})
}

export function openImg() {
	$(document).on("click", ".FinalimgContainer", function () {
		let img = this.querySelector('img')
		let src = img.getAttribute('src')
		let headertag = document.querySelector("head")
		return window.open('', '', '').document.write(headertag.innerHTML + this.innerHTML);
	})
}

// This shows the chart to print it
function printChart() {
	let headertag = document.querySelector("head")
	return window.open('', '', 'height=600,width=800').document.write(headertag.innerHTML + document.getElementById("chart_div").innerHTML)
}

// Final Detail table
const finalDetail = (id) => $('#detalleAuditoria_final').DataTable({
	language: { url: server + '/assets/json/spanish.json', },
	dom: 'lBfrtip',
	lengthMenu: [
		[10, 25, 50, -1],
		["10 Registros", "25 Registros", "50 Registros", "Mostrar Todos"]
	],
	ajax: {
		url: server + '/boarding/getFinalDetail',
		data: { id: id },
		dataSrc: ''
	},
	columns: [
		{ data: 'posicion_desc' },
		{ data: 'punto' },
		{ data: 'punto_desc' },
		{ data: 'imagenes' },
		{ data: 'comentario' },
		{ data: 'resultado' }
	],
	buttons: [
		// Copy Button
		{
			extend: 'copyHtml5',
			text: '<i class="fa-regular fa-copy fa-lg"></i>',
			title: 'Detalle de Auditoria',
			titleAttr: 'Copiar',
			className: 'btn btnCopy btn-sm',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5]
			}
		},
		// Button export to Excel
		{
			customize: function (window) {

			},
			extend: 'excelHtml5',
			text: '<i class="fa-regular fa-file-excel fa-lg"></i>',
			title: 'Detalle de Auditoria',
			titleAttr: 'Excel',
			className: 'btn btnExcel btn-sm',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5]
			}
		},
		// Button Create a PDF File
		{
			customize: function (window) {

			},
			extend: 'pdfHtml5',
			text: '<i class="fa-regular fa-file-pdf fa-lg"></i>',
			title: 'Detalle de Auditoria',
			titleAttr: 'PDF',
			className: 'btn btnPDF btn-sm',
			exportOptions: {
				columns: [0, 1, 2, 3, 4, 5]
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
				columns: [0, 1, 2, 3, 4, 5]
			}
		}
	],
	bDestroy: true,
	iDisplayLength: 10,
	order: [
		[1, "asc"]
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
					return 'Detalle de la Auditoria';
				}
			}),
			"renderer": $.fn.dataTable.Responsive.renderer.tableAll()
		}
	}
});

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
		url: server + '/boarding/getAudits',
		dataSrc: ''
	},
	columns: [
		{
			type: 'html-num',
			data: 'row'
		},
		{ data: 'Fecha' },
		{ data: 'Semana' },
		{ data: 'Mes' },
		{ data: 'Area_Nombre' },
		{ data: 'Pasa' },
		{ data: 'Falla' },
		{ data: 'Resultado' },
		{ data: 'editar' }
	],
	buttons: [
		// Copy Button
		{
			extend: 'copyHtml5',
			text: '<i class="fa-regular fa-copy fa-lg"></i>',
			title: 'Listado de Auditorias',
			titleAttr: 'Copiar',
			className: 'btn btnCopy btn-sm',
			exportOptions: {
				columns: [0, 2, 3, 4, 5, 6, 7]
			}
		},
		// Button export to Excel
		{
			customize: function (window) {

			},
			extend: 'excelHtml5',
			text: '<i class="fa-regular fa-file-excel fa-lg"></i>',
			title: 'Listado de Auditorias',
			titleAttr: 'Excel',
			className: 'btn btnExcel btn-sm',
			exportOptions: {
				columns: [0, 2, 3, 4, 5, 6, 7]
			}
		},
		// Button Create a PDF File
		{
			customize: function (window) {

			},
			extend: 'pdfHtml5',
			text: '<i class="fa-regular fa-file-pdf fa-lg"></i>',
			title: 'Listado de Auditorias',
			titleAttr: 'PDF',
			className: 'btn btnPDF btn-sm',
			exportOptions: {
				columns: [0, 2, 3, 4, 5, 6, 7]
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
				columns: [0, 2, 3, 4, 5, 6, 7]
			}
		},
		// Button to open a Modal
		{
			action: function () {
				setComboBox(0, 2, false, "#posicion")
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
	language: {
		url: server + '/assets/json/spanish.json',
	},
	dom: 'lfrtip',
	lengthMenu: [
		[10, 25, 50, -1],
		["10 Registros", "25 Registros", "50 Registros", "Mostrar Todos"]
	],
	ajax: {
		url: server + '/boarding/getAuditDetailTemp',
		data: { id: id },
		dataSrc: ''
	},
	columns: [
		{ data: 'posicion_desc' },
		{ data: 'punto' },
		{ data: 'punto_desc' },
		{ data: 'acciones' },
		{ data: 'imagenes' },
		{ data: 'comment' }
	],
	bDestroy: true,
	iDisplayLength: 10,
	order: [
		[1, "asc"]
	],
	orderCellsTop: true,
	fixedHeader: true,
	responsive: {
		details: {
			display: $.fn.dataTable.Responsive.display.modal({
				header: function (row) {
					var data = row.data();
					return 'Detalle de la Auditoria';
				}
			}),
			"renderer": $.fn.dataTable.Responsive.renderer.tableAll()
		}
	}
});

// Current Auditory table
export const current_audit = () => $('#current-audit-tab').click(function () {
	$.ajax({
		type: "get",
		url: server + '/boarding/getAuditTemp',
		success: function (r) {
			let data = JSON.parse(r)
			// Creating Date format
			const date = new Date(2023, data[0].Mes - 1);

			// Obtaining the month name based on the previous format
			const monthName = date.toLocaleString('es-ES', { month: 'long' });
			const month = monthName.charAt(0).toUpperCase() + monthName.slice(1);

			$("#failed-p").text(data[0].Falla)
			$("#passed-p").text(data[0].Pasa)
			$("#audited-p").text(data[0].Auditados)
			$("#week-a").text(data[0].Semana)
			$("#month-a").text(month)
			$("#result-a").text(parseFloat(new Intl.NumberFormat('de-DE', { style: 'percent' }).format(data[0].Resultado)) + "%")

		}
	});
})