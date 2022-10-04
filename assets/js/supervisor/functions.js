export const getSupervisorOption = (ComboBoxId) => {
	// Adding Supervisors to combobox
	$.ajax({
		type: "get",
		url: server + `/supervisor/getSupervisorOptions`,
		success: function (r) {
			let data = JSON.parse(r);

			// Clearing select
			$(ComboBoxId+" option").each(function() {
				if ($(this).val() >= 1) {
					$(this).remove()
				}
			});

			// Filling select
			document.querySelector("#default_supoption").setAttribute("selected", true)
			$(data).appendTo(ComboBoxId);
		}
	});
}