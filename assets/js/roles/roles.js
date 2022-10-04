import * as roles  from "./functions.js";
import * as config from "./datatable.config.js";

window.addEventListener('load', function () {
	config.DataTable()
	roles.onButtonDeleteClick()
	roles.getStatus()
}, false);

