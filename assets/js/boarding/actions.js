const editButton = () => {
	// Hidding the responsive data modal
	$(".dtr-bs-modal").modal('hide')
	return true
};

function pointAuditAction (id /* <- Point id */, auditResult) {
	$(".b-"+id).attr('disabled',true);
	let supervisor = $("#supervisor").val();
	let position = $("#posicion").val();

	$.ajax({
		type: "post",
		url: server + "/boarding/setTempAudit",
		data: {
			pid: id,
			res: auditResult,
			sup: supervisor,
			pos: position
		},
		success: (r) => {
			let data = JSON.parse(r)

			$('.toast-title').text(data.title);
			$('.toast-subtitle').text(data.subtitle);
			$('.toast-body').text(data.body);
			formatToast(data.status, data.color)
			$('#detalleAuditoria').DataTable().ajax.reload()
			return toast.show()	
		}
	})
}