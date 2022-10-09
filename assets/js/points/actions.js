function editButton (id) {
	// Hidding the responsive data modal
	$(".dtr-bs-modal").modal('hide')

	// Formatting input's modal
	$('.modal-title').text("Editar Punto de Auditoria Boarding")
	$('.modal-content').removeClass('bg-primary')
	$('.modal-content').addClass('bg-orangered')

	$.ajax({
		type: "get",
		url: server + '/points/editBoarding_data',
		data: {id_crypted: id},
		success: (r) => {
			data = JSON.parse(r)

			setComboBox(data.id, 2, false, "#posicion")
			$('#punto').val(data.punto)
			$('#descripcion').val(data.descripcion)
			$('#pointsModal').modal('show')


			// document.querySelector('.toast-title').textContent = data.header
			// document.querySelector('.toast-subtitle').textContent = data.subtitle
			// document.querySelector('.toast-body').textContent = data.response
			// formatToast(data.status, data.color)
			// return toast.show()
		},
		error: (e) => {
			return console.error(e.status, e.statusText, e.responseText);
		}
	});
	
}

const setComboBox = (id, area, selected, comboBoxId) => {
	id = id || false
	
	$.ajax({
		type: "get",
		url: server + '/positions/setComboBox',
		data: {
			id: id,
			area: area
		},
		success: (r) => {
			let data = JSON.parse(r);

			// Clearing select
			$(comboBoxId +" option").each(function() {
				if ($(this).val() >= 1) {
					$(this).remove()
				}
			});

			// Filling select
			if (selected == true) {$("#default_posoption").attr("selected", true)}
			$(data).appendTo(comboBoxId)
		},
		error: (e) => {
			return console.error(e.status, e.statusText, e.responseText);
		}
	});
}