export const setComboBox = (id, area, selected, comboBoxId) => {
	id = id || false
	let comboBoxVal = $(comboBoxId).val() || false
	
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
			if (comboBoxVal != false) {$(comboBoxId).val(comboBoxVal)}
		},
		error: (e) => {
			return console.error(e.status, e.statusText, e.responseText);
		}
	});
}