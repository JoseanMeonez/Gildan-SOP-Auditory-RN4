// Responsive modal's margins function
export function mediaQuery() {
	let mediaQuery1 = window.matchMedia("(max-width: 768px)")
	let mediaQuery2 = window.matchMedia("(min-width: 769px)")

	if(mediaQuery2.matches) {
		$(".contenido-modal").addClass("mx-5")
		$(".contenido-modal").addClass("g-3");
		$(".modal-body").addClass("mx-5");
	}

	mediaQuery1.addListener((e) => {
		e.preventDefault()
		if(e.matches) {
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
			if ( $(".detail_table").first().is( ":hidden" ) ) {
				return $(".detail_table").slideDown( "slow" )
			}
		}
	})
}

export function showAndHideTable() {
	$(".detail_table").hide()
	$("#showTable").click(function () {
    if ( $(".detail_table").first().is( ":hidden" ) ) {
      return $(".detail_table").slideDown( "slow" )
    } else {
      return $(".detail_table").slideUp( "slow" )
    }
  });
}

// This add the needed container to show the images
export function addImageComponent() {
	if (document.querySelector("#imagen-auditoria")) {
		let btnAddImage = document.querySelector("#imagen-auditoria");
		btnAddImage.onclick = function (e) {
			e.preventDefault()
			let key = Date.now();
			let newElement = document.createElement("div");
			newElement.id = "div" + key;
			newElement.innerHTML = (`
				<div class="prevImage rounded shadow-sm">
					<img src="${server}/assets/images/loading.svg" style="width:40%;">
				</div>
				<input type="file" name="photo" id="img${key}" class="inputUploadFile btn">
				<label for="img${key}" class="btnUploadFile btn btn-sm btn-success shadow-sm">
					<i class="fas fa-upload"></i>
				</label>
				<button type="button" class="btnDeleteFile btn btn-sm btn-danger shadow-sm" onclick="deleteImage('#div${key}')">
					<i class="fas fa-trash-alt"></i>
				</button>
			`);
			document.querySelector("#img-comment").classList.add("d-none")
			document.querySelector("#imagesContainer").appendChild(newElement);
			document.querySelector("#div" + key + " .btnUploadFile").click();
			return inputFile();
		}
	}
	return inputFile();
}

// Adding the image container and sending to controller
export function inputFile() {
	let inputUploadFile = document.querySelectorAll(".inputUploadFile");
	inputUploadFile.forEach(function (inputUploadFile) {
		inputUploadFile.addEventListener('change', function () {
			// Variables
			let parentid = this.parentNode.getAttribute("id");
			let fileid = this.getAttribute("id");
			let uploadPhoto = document.querySelector("#" + fileid).value;
			let fileimg = document.querySelector("#" + fileid).files;
			let previmg = document.querySelector("#" + parentid + " .prevImage");
			let nav = window.URL || window.webkitURL;

			// Validation
			if (uploadPhoto != '') {
				let type = fileimg[0].type;
				let name = fileimg[0].name;

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
						url: server + "/boarding/addImageAudit",
						data: formData,
						contentType: false,
						processData: false,
						success: function (r) {
							let data = JSON.parse(r)

							if (data) {
								if (data.status) {
									previmg.innerHTML = `<img src="${urlObj}">`;
									document.querySelector("#" + parentid + " .btnDeleteFile").setAttribute("imgname", name);
									// document.querySelector("#" + parentid + " .btnUploadFile").classList.add("d-none");
									// document.querySelector("#" + parentid + " .btnDeleteFile").classList.remove("d-none");
								}
								
								// Filling toast
								document.querySelector('.toast-title').textContent = data.header
								document.querySelector('.toast-subtitle').textContent = data.subtitle
								document.querySelector('.toast-body').textContent = data.response
								
								formatToast(data.status, data.color)
								return toast.show()
							}
						}
					});
				}
			}
		});
	});
}

// Calling delete image function from controller
export function deleteImage(elementid) {
	let imgname = document.querySelector(elementid + ' .btnDeleteFile').getAttribute('imgname');
	let productid = document.querySelector("#txtid").value;
	// let request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
	// let ajaxUrl = base_url + '/products/deleteImage';

	// let formData = new FormData;
	// formData.append('productid', productid);
	// formData.append('file', imgname);
	// request.open('post', ajaxUrl, true);
	// request.send(formData);
	// request.onreadystatechange = function () {
	// 	if (request.readyState != 4) return;
	// 	if (request.status == 200) {
	// 		let objData = JSON.parse(request.responseText);
	// 		if (objData.status) {
				let itemRemover = document.querySelector(elementid);
				itemRemover.parentNode.removeChild(itemRemover);
				// toastr.options.progressBar = true;
				// toastr.options.closeButton = true;
				// toastr.warning(objData.msg, objData.title);
			// } else {
			// 	Swal.fire("Error", objData.msg, "error");
			// }

		// }
	// }
}
