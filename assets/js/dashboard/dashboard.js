import * as config from "./datatable.config.js";
import * as fn from "./functions.js";

window.addEventListener('load', () => {
	// Combobox config setted
	fn.ComboboxManager(config.datatable)

	// Main table
	config.datatable(0,0,0,0)	
	config.datatableFilter()

})