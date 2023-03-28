export const datatableFilter = () => $('#tblDashboard thead tr').clone(true).addClass('filters').appendTo('#tblDashboard thead')

function drawChart(res) {
	// Load the Visualization API and the corechart package.
	google.charts.load('current', {
		'packages': ['corechart']
	});

	google.charts.setOnLoadCallback(() => {
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
				[res[i].Posicion_Desglosada, parseInt(res[i].Puntos_Fallados)]
			]);
		}

		// Set chart options
		let options = {
			title: `Posiciones con puntos fallados del mes de ${res[0].Mes} de ${res[0].Año}`,
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
			responsive: true,
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
				6: { offset: 0.02 },
				7: { offset: 0.02 },
				8: { offset: 0.02 },
				9: { offset: 0.02 },
				10: { offset: 0.02 },
				11: { offset: 0.02 },
				12: { offset: 0.02 },
				13: { offset: 0.02 },
				14: { offset: 0.02 },
				15: { offset: 0.02 },
				16: { offset: 0.02 },
				17: { offset: 0.02 },
				18: { offset: 0.02 },
				19: { offset: 0.02 },
				20: { offset: 0.02 },
			},
			// colors: ["#6ab04c", "#7fc77e", "#9bd5b2", "#b5e3d5", "#c5ecd9"],
			// is3D: true,
			pieStartAngle: 45
		}

		// Instantiate and draw our chart, passing in some options.
		var chart = new google.visualization.PieChart(document.getElementById('chart_div'))
		return chart.draw(data, options)
	})
}

// Datatable properties
export const datatable = (area, year, month, week) => $('#tblDashboard').DataTable({
	language: { url: server + '/assets/json/spanish.json' },
	dom: 'lBfrtip',
	lengthMenu: [
		[10, 25, 50, 100, -1],
		["10 Registros", "25 Registros", "50 Registros", "100 Registros", "Mostrar Todos"]
	],
	ajax: {
		url: server + '/dashboard/getAllAuditDetails',
		data: {
			area: area,
			year: year,
			month: month,
			week: week
		},
		dataSrc: ''
	},
	columns: [
		{ data: 'Area_Nombre' },
		{ data: 'Mes' },
		{ data: 'Semana' },
		{ data: 'Posicion_Desc' },
		{ data: 'Puntos_Pasados' },
		{ data: 'Puntos_Fallados' },
		{ data: 'Resultado' }
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
				columns: [0, 1, 2, 3, 4, 5, 6]
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
				columns: [0, 1, 2, 3, 4, 5, 6]
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
				columns: [0, 1, 2, 3, 4, 5, 6]
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
				columns: [0, 1, 2, 3, 4, 5, 6]
			}
		}
	],
	bDestroy: true,
	iDisplayLength: 10,
	order: [
		[0, "asc"]
	],
	orderCellsTop: true,
	fixedHeader: true,
	initComplete: function (settings, json) {
		// Executing the chart after the table is charged
		drawChart(json)
		
		var api = this.api();
		// For each column
		api.columns().eq(0).each(function (colIdx) {
			// Set the header cell to contain the input element
			var cell = $('.filters th').eq($(api.column(colIdx).header()).index());
			var title = $(cell).text();
			$(cell).html('<input class="form form-control text-center frmDT" type="text" placeholder="' + title + '"/>');
			// On every keypress in this input
			$('input', $('.filters th').eq($(api.column(colIdx).header()).index())).off('keyup change').on('keyup change', function (e) {
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
					return 'Detalle de las Auditorías';
				}
			}),
			renderer: $.fn.dataTable.Responsive.renderer.tableAll()
		}
	}
});