import * as config from './datatable.config.js'
import * as fn from './functions.js'

window.addEventListener('load', () => {
	// Main table
	config.datatable()
	config.datatableFilter()
	
	// Modal media querys and features
	fn.mediaQuery()
	fn.showAndHideTable()
	fn.ComboxesManager(config.detailTable)
	config.current_audit()
	
	// Create modal tables and content:
	fn.addImageComponent()
	fn.point_action();
})

