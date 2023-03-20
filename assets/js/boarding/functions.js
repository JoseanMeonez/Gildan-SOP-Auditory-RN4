// Responsive modal's margins function
export function mediaQuery() {
	let mediaQuery1 = window.matchMedia("(max-width: 768px)")
	let mediaQuery2 = window.matchMedia("(min-width: 769px)")

	if (mediaQuery2.matches) {
		$(".contenido-modal").addClass("mx-5")
		$(".contenido-modal").addClass("g-3");
		$(".modal-body").addClass("mx-5");
	}

	mediaQuery1.addListener((e) => {
		e.preventDefault()
		if (e.matches) {
			$(".contenido-modal").removeClass("mx-5")
			$(".contenido-modal").removeClass("g-3");
			$(".modal-body").removeClass("mx-5");
		} else {
			$(".contenido-modal").addClass("mx-5")
			$(".contenido-modal").addClass("g-3");
			$(".modal-body").addClass("mx-5");
		}
	})

	return true
}

// This controls the comboboxes actions
export function ComboxesManager(detailTable) {
	$("#posicion").attr("disabled", true);

	// This enable or disable the position combox according with the supervisor combobox value
	$("#supervisor").change(function () {
		if ($("#supervisor").val() > 0) {
			return $("#posicion").attr("disabled", false);
		} else {
			return $("#posicion").attr("disabled", true);
		}
	})

	// This execute the details table accorfing with the position combobox value
	$("#posicion").change(function () {
		if ($("#posicion").val() > 0) {
			detailTable($("#posicion").val())
			if ($(".detail_table").first().is(":hidden")) {
				return $(".detail_table").slideDown("slow")
			}
		}
	})
}

export function showAndHideTable() {
	$(".detail_table").hide()
	$("#showTable").click(function () {
		if ($(".detail_table").first().is(":hidden")) {
			return $(".detail_table").slideDown("slow")
		} else {
			return $(".detail_table").slideUp("slow")
		}
	});
}

// Adding the image container and sending to controller
export function inputFile() {
	$(document).on("change", ".inputUploadFile", function () {
			// Variables
			let parentid = this.parentNode.getAttribute("id");
			let fileid = this.getAttribute("id");
			let point_id = this.getAttribute("dataid");
			let uploadPhoto = document.querySelector("#" + fileid).value;
			let fileimg = document.querySelector("#" + fileid).files;
			let previmg = document.querySelector("#" + parentid + " .prevImage");
			let nav = window.URL || window.webkitURL;

			// Validation
			if (uploadPhoto != '') {
				let type = fileimg[0].type;

				// Extension validation
				if (type != 'image/jpeg' && type != 'image/jpg' && type != 'image/png') {
					previmg.innerHTML = "Archivo no válido.";
					uploadPhoto.value = "";
					return false;
				} else {

					let urlObj = nav.createObjectURL(fileimg[0]);
					let formData = new FormData()
					formData.append('photo', fileimg[0])

					$.ajax({
						type: "post",
						url: server + "/boarding/addImageAudit/" + point_id,
						data: formData,
						contentType: false,
						processData: false,
						success: function (r) {
							let data = JSON.parse(r)

							if (data) {
								if (data.status) {
									// Reloading table
									$('#detalleAuditoria').DataTable().ajax.reload()
								}

								// Filling toast
								document.querySelector('.toast-title').textContent = data.header
								document.querySelector('.toast-subtitle').textContent = data.subtitle
								document.querySelector('.toast-body').textContent = data.response

								formatToast(data.status, data.color)
								return toast.show()
							}
						}
					})
				}
			}
		})
}

// Calling delete image function from controller
export function deleteImage(elementid) {
	$(document).on("click", ".btnDeleteFile", function () {
		// Variables
		let point_id = this.getAttribute("dataid")

		$.ajax({
			type: "post",
			url: server + "/boarding/deleteImageAudit/" + point_id,
			contentType: false,
			processData: false,
			success: function (r) {
				let data = JSON.parse(r)

				if (data.status) {
					// Reloading table
					$('#detalleAuditoria').DataTable().ajax.reload()
				}

				// Filling toast
				document.querySelector('.toast-title').textContent = data.header
				document.querySelector('.toast-subtitle').textContent = data.subtitle
				document.querySelector('.toast-body').textContent = data.response

				formatToast(data.status, data.color)
				return toast.show()
			}
		})
	})
}

export function point_action() {
	$(document).on("change", ".point_actions", function () {
		let supervisor = $("#supervisor").val()
		let position = $("#posicion").val()
		let id = this.getAttribute('id')
		let auditResult = this.value;

		if (auditResult == 3) {
			document.querySelector("#add_photo" + id).click()
		}

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

				$('.toast-title').text(data.title)
				$('.toast-subtitle').text(data.subtitle)
				$('.toast-body').text(data.body)
				formatToast(data.status, data.color)
				// $('#detalleAuditoria').DataTable().ajax.reload()

				return toast.show()
			}
		})
	})
}

// This add the needed container to show the images
export function addImageComponent() {
	$(document).on("click", ".add_photo", function (e) {
		e.preventDefault()
		let id = this.getAttribute('binid')
		let key = Date.now();
		let newElement = document.createElement("div");
		newElement.id = "div" + key;
		// newElement.innerHTML = (`
		// 	<div class="prevImage rounded shadow-sm">
		// 		<img src="${server}/assets/images/loading.svg" style="width:40%;">
		// 	</div>
		// 	<input type="file" name="photo" id="img${key}" dataid="${id}" class="inputUploadFile btn">
		// 	<label for="img${key}" class="btnUploadFile btn btn-sm btn-success shadow-sm">
		// 		<i class="fas fa-upload"></i>
		// 	</label>
		// 	<button type="button" class="btnDeleteFile btn btn-sm btn-danger shadow-sm" onclick="deleteImage('#div${key}')">
		// 		<i class="fas fa-trash-alt"></i>
		// 	</button>
		// `);

		newElement.innerHTML = (`
			<input type="file" name="photo" id="img${key}" dataid="${id}" class="inputUploadFile btn">
			<label for="img${key}" class="btnUploadFile btn btn-sm btn-success shadow-sm d-none">
				<i class="fas fa-upload"></i>
			</label>
		`);
		// document.querySelector("#img-comment").classList.add("d-none")
		document.querySelector("#imagesContainer" + id).appendChild(newElement);
		document.querySelector("#div" + key + " .btnUploadFile").click();
		// return inputFile();
	})
}

export function save_comment() {
	$(document).on("keyup", ".comment_input", function (e) {
		let supervisor = $("#supervisor").val()
		let position = $("#posicion").val()

		setTimeout(() => {	
			$.ajax({
				type: "post",
				url: server + "/boarding/setCommentTemp",
				data: {
					pid: this.getAttribute("dataid"),
					sup: supervisor,
					pos: position,
					com: this.value
				},
				success: (r) => {
					let data = JSON.parse(r)
					console.info(data);
				}
			})
		}, 5000);
	})
}

export function save_audit() {
	$(document).on("click", "#guardarAuditoria", function () {
		$.ajax({
			type: "post",
			url: server + "/boarding/AuditCompleted",
			success: (r) => {
				let data = JSON.parse(r)

				$('.toast-title').text(data.title)
				$('.toast-subtitle').text(data.subtitle)
				$('.toast-body').text(data.body)
				formatToast(data.status, data.color)
				if (data.status == 1) {
					$('#tblBoarding').DataTable().ajax.reload()
					$('#detalleAuditoria').DataTable().ajax.reload()
					$('#addAuditBoarding').modal('hide')
				}
				
				return toast.show()
			}
		})
	})
}

export function clear_audit() {
	$(document).on("click", "#limpiarAuditoria", function () {
		console.log(this)
	})
}