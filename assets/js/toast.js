// Toast object
var toast = new bootstrap.Toast($('#liveToast'))

// This arrow function give a format to the toast
const formatToast = (status, color, modalid) => {
	modalid = modalid || false
	// Styling toast
	if (status == true && color == 1 && modalid >= 1) {
		// Removing other classes
		$('#liveToast').removeClass('bg-danger');
		$('#liveToast').removeClass('bg-warning');
		$('.toast-body').removeClass('text-dark');


		$('#liveToast').addClass('bg-success');
		$('.toast-body').addClass('text-light');

		$(modalid).modal('hide');
	} if (status == true && color == 1) {
		// Removing other classes
		$('#liveToast').removeClass('bg-danger');
		$('#liveToast').removeClass('bg-warning');
		$('.toast-body').removeClass('text-dark');


		$('#liveToast').addClass('bg-success');
		$('.toast-body').addClass('text-light');
	} else if (status == false && color == 3) {
		// Removing other classes
		$('#liveToast').removeClass('bg-danger');
		$('.toast-body').removeClass('text-light');
		$('#liveToast').removeClass('bg-success');

		$('#liveToast').addClass('bg-warning');
		$('.toast-body').addClass('text-dark');
	} else {
		// Removing other classes
		$('#liveToast').removeClass('bg-success');
		$('#liveToast').removeClass('bg-warning');
		$('.toast-body').removeClass('text-dark');

		$('#liveToast').addClass('bg-danger');
		$('.toast-body').addClass('text-light');
	}
}