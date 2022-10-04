// Responsive modal's margins function
export function mediaQuerys() {
	let mediaQuery = window.matchMedia("(max-width: 768px)")

	mediaQuery.addListener((e) => {
		if(e.matches) {
			document.querySelector(".contenido-modal").classList.remove("mx-5")
			document.querySelector(".contenido-modal").classList.remove("g-3")
			document.querySelector(".modal-body").classList.remove("mx-5")
		} else {
			document.querySelector(".contenido-modal").classList.add("mx-5")
			document.querySelector(".contenido-modal").classList.add("g-3")
			document.querySelector(".modal-body").classList.add("mx-5")
		}
	})

	return true
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
			inputFile();
		}
	}
	inputFile();
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

							if (data.status) {
								previmg.innerHTML = `<img src="${urlObj}">`;
								document.querySelector("#" + parentid + " .btnDeleteFile").setAttribute("imgname", name);
								// document.querySelector("#" + parentid + " .btnUploadFile").classList.add("d-none");
								// document.querySelector("#" + parentid + " .btnDeleteFile").classList.remove("d-none");
								
								// Filling toast
								document.querySelector('.toast-title').textContent = data.header
								document.querySelector('.toast-subtitle').textContent = data.subtitle
								document.querySelector('.toast-body').textContent = data.response
								
								formatToast(data.status, data.color)
								toast.show()
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
