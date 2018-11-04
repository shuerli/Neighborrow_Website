// Global Variable
let filter_switch = false;


$("#filter_init").click(function () {
	if (!filter_switch) {
		$("#filter_init").removeClass("btn-outline-info");
		$("#filter_init").addClass("btn-outline-danger");
		$("#filter_init").html("Clear Filters");
		filter_switch = true;
	}
	else {
		$("#filter_init").removeClass("btn-outline-danger");
		$("#filter_init").addClass("btn-outline-info");
		$("#filter_init").html("More Filters");
		filter_switch = false;
	}
});


$(document).ready(function(){
	
})
