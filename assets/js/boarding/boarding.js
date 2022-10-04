import * as config from './datatable.config.js'
import * as fn from './functions.js'

window.addEventListener('load', () => {
	// Main table
	config.datatable()
	config.datatableFilter()
	
	// Modal media query
	fn.mediaQuerys()
	
	// Create modal tables and content:
	config.detailTable(1)
	fn.addImageComponent()
})

