<?= component('header', $data) ?>
<!--Load the AJAX API-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	// Load the Visualization API and the corechart package.
	google.charts.load('current', {
		'packages': ['corechart']
	});

	// Set a callback to run when the Google Visualization API is loaded.
	google.charts.setOnLoadCallback(drawChart);

	// Callback that creates and populates a data table,
	// instantiates the pie chart, passes in the data and
	// draws it.
	function drawChart() {

		// Create the data table.
		// var data = new google.visualization.DataTable();
		// data.addColumn('string', 'Topping');
		// data.addColumn('number', 'Slices');
		// data.addRows([
		// 	['Mushrooms', 3],
		// 	['Onions', 1],
		// 	['Olives', 1],
		// 	['Zucchini', 1],
		// 	['Pepperoni', 2]
		// ]);
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
</script>
<!-- Main -->
<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="breadcrumb-item__icon <?= $data['page_icon']; ?> fa-lg"></i>
				<span><?= $data['page_title']; ?></span>
			</h1>
			<p><?= $data['page_description']; ?></p>
		</div>
		<ul class="app-breadcrumb breadcrumb">
			<li class="breadcrumb-item">
				<i class="breadcrumb-item__icon <?= $data['page_icon']; ?> fa-xl"></i>
				<a><?= $data['page_breadcrumb']; ?></a>
			</li>
		</ul>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="tile">
				<div class="tile-body">
					<h4>
						Hola de nuevo
						<?= $_SESSION['userdata']['name'][0] ?>
						
					</h4>
					<!--Div that will hold the chart-->
					<div id="chart_div"></div>
				</div>
			</div>
		</div>
	</div>
</main>

<?= component('footer', $data) ?>