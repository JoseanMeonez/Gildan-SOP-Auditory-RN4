import * as user from "./functions.js";
import * as config from "./datatable.config.js";

window.addEventListener('load', function () {
	config.datatable()
	config.datatableFilter()
	user.TextAreas()
	user.getEmployees()
	user.getRoles()
	user.getStatus()
	user.onButtonDeleteClick()
}, false);