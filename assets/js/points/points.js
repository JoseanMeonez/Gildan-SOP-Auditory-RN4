import * as table from './datatables.config.js'

window.addEventListener('load', () => {
	if (document.getElementById('table-knitting')) {
		console.log('Knitting');
	} else if (document.getElementById('table-dyeing')) {
		console.log('Dyeing');
	} else if (document.getElementById('table-boarding')) {

		// Main table
		table.boarding()
		table.datatableFilter('table-boarding')


	} else {
		console.error('No se encontró datos');
	}
})