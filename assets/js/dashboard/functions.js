// This controls the comboboxes actions
export function ComboboxManager(datatable) {
	$("#year").attr("disabled", true);
	$("#month").attr("disabled", true);
	$("#week").attr("disabled", true);


	// This enable or disable the position combox according with the combobox value
	$("#area").change(function () {
		if ($("#area").val() > 0) {
			getYearOptions($("#area").val())
			return $("#year").attr("disabled", false);
		} else {
			return $("#year").attr("disabled", true);
		}
	})

	$("#year").change(function () {
		if ($("#area").val() > 0 && $("#year").val() > 0) {
			getMonthOptions($("#area").val(), $("#year").val());
			return $("#month").attr("disabled", false);
		} else {
			return $("#month").attr("disabled", true);
		}
	})

	$("#month").change(function () {
		if ($("#area").val() > 0 && $("#year").val() > 0 && $("#month").val() > 0) {
			getWeekOptions($("#area").val(), $("#year").val(), $("#month").val());
			return $("#week").attr("disabled", false);
		} else {
			return $("#week").attr("disabled", true);
		}
	})

	$("#week").change(function () {
		if ($("#area").val() > 0 && $("#year").val() > 0 && $("#month").val() > 0 && $("#week").val() > 0) {
			datatable($("#area").val(), $("#year").val(), $("#month").val(), $("#week").val())
		} else {
			datatable(0,0,0,0)
		}
	})
}

// This fill the options
const getYearOptions = (area) => {
	// Adding data to combobox
	$.ajax({
		type: "get",
		url: server + `/dashboard/getYearOptions`,
		data: {
			area: area
		},
		success: function (r) {
			let data = JSON.parse(r);

			// Clearing select
			$("#year option").each(function() {
				if ($(this).val() >= 1) {
					$(this).remove()
				}
			});

			// Filling select
			document.querySelector("#default_yearoption").setAttribute("selected", true)
			$(data).appendTo("#year");
		}
	});
}

// This fill the options
const getMonthOptions = (area, year) => {
	// Adding data to combobox
	$.ajax({
		type: "get",
		url: server + `/dashboard/getMonthOptions`,
		data: {
			area: area,
			year: year
		},
		success: function (r) {
			let data = JSON.parse(r);

			// Clearing select
			$("#month option").each(function() {
				if ($(this).val() >= 1) {
					$(this).remove()
				}
			});

			// Filling select
			document.querySelector("#default_monthoption").setAttribute("selected", true)
			$(data).appendTo("#month");
		}
	});
}

// This fill the options
const getWeekOptions = (area, year, month) => {
	// Adding data to combobox
	$.ajax({
		type: "get",
		url: server + `/dashboard/getWeekOptions`,
		data: {
			area: area,
			year: year,
			month: month
		},
		success: function (r) {
			let data = JSON.parse(r);

			// Clearing select
			$("#week option").each(function() {
				if ($(this).val() >= 1) {
					$(this).remove()
				}
			});

			// Filling select
			document.querySelector("#default_weekoption").setAttribute("selected", true)
			$(data).appendTo("#week");
		}
	});
}