// Login Page Flipbox control
$('.login-content [data-bs-toggle="flip"]').click(function () {
	$('.login-box').toggleClass('flipped');
	return false;
});

var divLoading = document.querySelector("#divLoading");

document.addEventListener('DOMContentLoaded', function () {
	/* <<========== Inicio de sesion en la aplicacion ==========>> */
	if (document.querySelector("#frmLogin")) {
		let formLogin = document.querySelector("#frmLogin");
		formLogin.onsubmit = function (e) {
			e.preventDefault();
			divLoading.style.display = "flex";
			
			let user = document.querySelector("#txtusername").value;
			let pass = document.querySelector("#txtpassword").value;
			
			if (user == "" || pass == "") {
				Swal.fire('Campos obligatorios', 'Los campos de usuario y contraseñas son obligatorios', 'error');
				divLoading.style.display = "none";
				return false;
			} else {
				var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
				var ajaxUrl = server + '/login/loginUser';
				var formData = new FormData(formLogin);
				request.open("POST", ajaxUrl, true);
				request.send(formData);

				request.onreadystatechange = function () {
					if (request.readyState != 4) return;
					if (request.status = 200) {
						var objData = JSON.parse(request.responseText);

						if (objData.status) {
							Wellcome()
						} else {
							Swal.fire(objData.title, objData.msg, objData.icon);
							document.querySelector("#txtpassword").value = "";
						}
					} else {
						Swal.fire("Atención", "Ocurrio un error en el proceso", "error");
					}
					divLoading.style.display = "none";
					return false;
				}
			}
		}
	}

	/* <<========== Función de carga de mensaje de bienvenida ==========>> */
	function Wellcome() {
		window.location.reload(false);
	}

	/* <<========== Recuperación de usuario y/o Contraseña ==========>> */
	if (document.querySelector("#frmForget")) {
		let frmForget = document.querySelector("#frmForget");
		frmForget.onsubmit = function (e) {
			e.preventDefault();

			let email = document.querySelector('#txtemail').value;

			divLoading.style.display = "flex";
			var request = (window.XMLHttpRequest) ?
				new XMLHttpRequest() :
				new ActiveXObject('Microsoft.XMLHTTP');

			var ajaxUrl = server + '/login/resetPass';
			var formData = new FormData(frmForget);
			request.open("POST", ajaxUrl, true);
			request.send(formData);
			request.onreadystatechange = function () {
				if (request.readyState != 4) return;

				if (request.status == 200) {
					var objData = JSON.parse(request.responseText);

					console.log(objData);

					if (objData.status) {
						Swal.fire({
							title: objData.title,
							text: objData.msg,
							icon: objData.icon,
							confirmButtonText: "Aceptar",
							closeOnConfirm: false,
						}).then((result) => {
							if (result.isConfirmed) {
								window.location = server;
							}
						});
					} else {
						Swal.fire(objData.title, objData.msg, objData.icon);
					}
				} else {
					Swal.fire("Atención", "Error en el proceso", "error");
				}
				divLoading.style.display = "none";
				return false;
			}
		}
	}

	/* <<========== Cambio de Contraseña ==========>> */
	if (document.querySelector("#frmResetPass")) {
		let frmResetPass = document.querySelector("#frmResetPass");
		frmResetPass.onsubmit = function (e) {
			e.preventDefault();

			let pass1 = document.querySelector('#txtpass1').value;
			let pass2 = document.querySelector('#txtpass2').value;
			let id = document.querySelector('#txtid').value;

			if (pass1 == "" || pass2 == "") {
				Swal.fire("¡Atención!", "Por favor ingrese la nueva contraseña", "error");
				return false;
			} else {
				if (pass1.length < 5) {
					swal("¡Atención!", "La contraseña debe tener un mínimo de 5 caracteres.", "info");
					return false;
				}
				if (pass1 != pass2) {
					swal("¡Atención!", "Las contraseñas no coinciden", "error");
					return false;
				}

				divLoading.style.display = "flex";

				var request = (window.XMLHttpRequest) ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
				var ajaxUrl = server + '/login/setPassword';
				var formData = new FormData(frmResetPass);

				request.open("POST", ajaxUrl, true);
				request.send(formData);
				request.onreadystatechange = function () {
					if (request.readyState != 4) return;

					if (request.status == 200) {
						var objData = JSON.parse(request.responseText);

						if (objData.status) {
							Swal.fire({
								title: objData.title,
								text: objData.msg,
								icon: objData.icon,
								confirmButtonText: 'Iniciar sessión',
								// closeOnConfirm: false,
							}).then((result) => {
								if (result.isConfirmed) {
									window.location = server + '/login';
								}
							});
						} else {
							Swal.fire(objData.title, objData.msg, objData.icon);
						}
					} else {
						Swal.fire("Atención", "Error en el proceso", "error");
					}

					divLoading.style.display = "none";
				}
			}
		}
	}
}, false);