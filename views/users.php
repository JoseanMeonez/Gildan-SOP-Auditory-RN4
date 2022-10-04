<?=
component("header", $data);
//  getModal('mdlUsers', $data);
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
					<table id="tblUsers" class="table table-bordered table-hover table-striped table-sm display nowrap" cellpadding="0" width="100%">
						<thead class="bg bg-black text-light text-center">
							<tr>
								<th width="10%">No.</th>
								<th width="30%">Nombre del Empleado</th>
								<th width="20%">Rol</th>
								<th width="20%">Usuario</th>
								<th width="10%">Estado</th>
								<th width="10%">Acciones</th>
							</tr>
						</thead>
						<tbody class="text-center">
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
	component('footer', $data);
	getToasts();
?>