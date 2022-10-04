function getStatus() {
	if (document.querySelector('#lstStatus')) {
		let ajaxUrl = server + '/status/getStatus';
		let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');

		request.open("GET", ajaxUrl, true);
		request.send();
		request.onreadystatechange = function () {
			if (request.readyState == 4 && request.status == 200) {
				document.querySelector('#lstStatus').innerHTML = request.responseText;
			}
		}
	}
}

const onButtonDeleteClick = () => $(document).on('click', '.btnDele', function () {
	Swal.fire({
		title: '¿Desea eliminar este rol?',
		text: "¡Una vez sea eliminado, el rol ya no estará disponible!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#198754',
		cancelButtonColor: '#d33',
		confirmButtonText: '¡Proceder!',
		cancelButtonText: 'Cancelar',
		reverseButtons: true
	}).then((result) => {
		if (result.isConfirmed) {
			let url = server + '/roles/deleteRoles';
			let element = $(this)[0];
			let id = $(element).attr('rl');
			let rn = $(element).attr('rn');
			$.post(url, { id, rn }, function (response) {
				var objData = JSON.parse(response);
				if (objData.status) {
					Swal.fire(
						objData.title,
						objData.msg,
						objData.icon
					)
					$('#tblRoles').DataTable().ajax.reload();
				} else {
					Swal.fire(
						objData.title,
						objData.msg,
						objData.icon
					)
				}
			});
		} else if (
			result.dismiss === Swal.DismissReason.cancel
		) {
			Swal.fire(
				'Eliminación Cancelada', 'La eliminación del rol fue cancelada', 'error'
			)
		}
	})
});

export { getStatus, onButtonDeleteClick }