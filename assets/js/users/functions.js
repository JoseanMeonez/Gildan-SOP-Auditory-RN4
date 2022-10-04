function TextAreas() {
	var ta = document.getElementById('txtobservations');
	ta.setAttribute('style', '');
	ta.value = "";
}

function getEmployees() {
	$.ajax({
		type: "POST",
		url: "employees/getEmployees",
		success: function (r) {
			document.querySelector('#lstemployees').innerHTML = r;
		}
	});
}

function getRoles() {
	$.ajax({
		type: "POST",
		url: "roles/getRoles",
		success: function (r) {
			document.querySelector('#lstroles').innerHTML = r;
		}
	});
}

function getStatus() {
	if (document.querySelector('#lststatus')) {
		let ajaxUrl = server + '/status/getStatus';
		let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');

		request.open("GET", ajaxUrl, true);
		request.send();
		request.onreadystatechange = function () {
			if (request.readyState == 4 && request.status == 200) {
				document.querySelector('#lststatus').innerHTML = request.responseText;
			}
		}
	}
}

const onButtonDeleteClick = () => $(document).on('click', '.btnDele', function () {
	Swal.fire({
		title: '¿Desea eliminar este usuario?',
		text: "¡Una vez sea eliminado, el usuario ya no estará disponible!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#198754',
		cancelButtonColor: '#d33',
		confirmButtonText: '¡Proceder!',
		cancelButtonText: 'Cancelar',
		reverseButtons: true
	}).then((result) => {
		if (result.isConfirmed) {
			let url = server + '/users/deleteUsers'
			let element = $(this)[0]
			let eid = $(element).attr('eid')
			let id = $(element).attr('rl')
			let un = $(element).attr('un')
			let rn = $(element).attr('rn')
			$.post(url, { id, eid, un, rn }, function (response) {
				var objData = JSON.parse(response)
				if (objData.status) {
					Swal.fire(
						objData.title,
						objData.msg,
						objData.icon
					)
					$('#tblUsers').DataTable().ajax.reload();
				} else {
					Swal.fire(
						objData.title,
						objData.msg,
						objData.icon
					)
				}
			})
		} else if (result.dismiss === Swal.DismissReason.cancel) {
			Swal.fire(
				'Eliminación Cancelada', 'La eliminación del usuario fue cancelada', 'error'
			)
		}
	})
})

export { TextAreas, getEmployees, getRoles, getStatus, onButtonDeleteClick } 