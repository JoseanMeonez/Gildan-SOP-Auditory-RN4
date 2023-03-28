<?= component('header', $data) ?>

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
					<div class="row">
						<!-- Area -->
						<div class="col-md form-group form_info mb-3">
							<select class="form-select form_input" name="area" id="area">
								<option id="default_areaoption" disabled selected>Seleccione una opción</option>
								<option id="default_areaoption" value="1">Knitting</option>
								<option id="default_areaoption" value="2">Boarding</option>
								<option id="default_areaoption" value="3">Dyeing</option>
								<option id="default_areaoption" value="4">Fadis</option>
							</select>
							<label for="area" class="form_label">Area</label>
						</div>

						<!-- Year -->
						<div class="col-md form-group form_info mb-3">
							<select class="form-select form_input" name="year" id="year">
								<option id="default_yearoption" disabled selected>Seleccione una opción</option>
							</select>
							<label for="year" class="form_label">Año</label>
						</div>

						<!-- Month -->
						<div class="col-md form-group form_info mb-3">
							<select class="form-select form_input" name="month" id="month">
								<option id="default_monthoption" disabled selected>Seleccione una opción</option>
							</select>
							<label for="month" class="form_label">Mes</label>
						</div>

						<!-- Week -->
						<div class="col-md form-group form_info mb-3">
							<select class="form-select form_input" name="week" id="week">
								<option id="default_weekoption" disabled selected>Seleccione una opción</option>
							</select>
							<label for="week" class="form_label">Semana</label>
						</div>
					</div>

					<ul class="nav nav-pills nav-fill mx-5 mb-3" id="pills-tab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active fw-bold" id="workin-audit-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">Gráfico</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link fw-bold" id="current-audit-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">Tabla de Datos</button>
						</li>
					</ul>

					<div class="tab-content" id="pills-tabContent">
						<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
							<!--Div that will hold the chart-->
							<div id="chart_div"></div>
						</div>

						<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
							<table id="tblDashboard" class="table table-hover table-striped table-sm display nowrap" cellpadding="0" width="100%">
								<thead class="bg-gildan text-light text-center align-middle">
									<tr>
										<th>Area</th>
										<th>Mes</th>
										<th>Semana</th>
										<th>Posición</th>
										<th>Pasa</th>
										<th>Falla</th>
										<th>% Cumplimiento</th>
									</tr>
								</thead>
								<tbody class="text-center align-middle">
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<?= component('footer', $data) ?>