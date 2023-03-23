const editButton = () => {
	// Hidding the responsive data modal
	$(".dtr-bs-modal").modal('hide')
	return true
};

// Load the Visualization API and the corechart package.
google.charts.load('current', {
	'packages': ['corechart']
});

// Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawChart);


function drawChart() {
	var data = google.visualization.arrayToDataTable([
		['Date', 'Boarding', 'Knitting', 'Dyeing', 'Fadis'],
		['January',  0.98,      1.00,         0.97,   0.99],
		['February',  0.97,     1.00,        0.98,    1.00],
		['March',  1.00,      0.99,        0.98,     	0.97],
		['April',  0.97,      0.98,        1.00,      1.00],
		['May',  0.98,      1.00,         0.99,       0.97]
	]);

	// Set chart options
	var options = {
		title: 'Ultima auditoria',
		titleTextStyle: { fontSize: 20 },
		width: 600,
		height: 400,
		fontName: "Poppins",
		fontSize: 12,
		legend: {
			textStyle: {
				fontSize: 14,
				bold: true,
			},
			position: "left"
		},
		// is3D: true,
		slices: {
			0: { offset: 0.05 },
			1: { offset: 0.05 },
			2: { offset: 0.05 },
			3: { offset: 0.05 },
			4: { offset: 0.05 }
		},
		pieStartAngle: 45,
		// colors: ['#e0440e', '#e6693e', '#ec8f6e', '#f3b49f', '#f6c7b6']
	};

	// Instantiate and draw our chart, passing in some options.
	var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	chart.draw(data, options);
}