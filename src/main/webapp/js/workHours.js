$('#hoursTable').DataTable({
	language: {
		url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/pt-BR.json',
	},
});

$.extend(true, DataTable.defaults, {
	searching: false,
})

$('#workHours').DataTable({
	language: {
		url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/pt-BR.json',
	},
	info: false,
	paging: false,
});

function addWorkHours() {
	let startTime = formWorkHours.startTime.value;
	let exitTime = formWorkHours.exitTime.value;

	alert(' Você cadastrou a Entrada: ' + startTime + ' e a Saída: ' + exitTime);

	document.forms["formWorkHours"].submit();
}

function addRegisterHours() {
	let registerTime = formRegisterHours.registerTime.value;
	let now = formRegisterHours.timeNow.checked

	if (now === true) {
		var hour = new Date().toLocaleTimeString();
		alert("Registro no horário: " + hour);
		document.forms["formRegisterHours"].submit();
	} else {
		alert("Registro no horário: " + registerTime);
		document.forms["formRegisterHours"].submit();
	}
}

function editWorkHours(e){
	alert("Você quer editar o: " + e);
}

function excludeWorkHours(e){
	alert("Você quer excluir o horário: "+ e)
}
