<?= 
	component('header', $data);
?>

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
				<a href="<?= path; ?>">Inicio</a>
			</li>
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
					<table id="tblBoarding" class="table table-bordered table-hover table-striped table-sm display nowrap" cellpadding="0" width="100%">
						<thead class="bg bg-black text-light text-center align-middle">
							<tr>
								<th>No.</th>
								<th>Fecha</th>
								<th>Semana</th>
								<th>Mes</th>
								<th>Area</th>
								<th>Pasa</th>
								<th>Falla</th>
								<th>% Cumplimiento</th>
								<th>Acciones</th>
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
							<td></td>
							<td></td>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</main>

<?=
	getModal('nuevaAuditoriaBoarding', $data);
	component('footer', $data)
?>