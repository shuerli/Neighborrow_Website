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


/*
	Functional buttons for each borrowed items
	1. Completed
		- Provide Feedback (if no feedback is associated with this request)
		- Contact lender
		- Borrow this again
		- Request for help 
	2. Cancelled
		- Re-submit a request
		- Contact lender
	    - Request for help
	3. Rejected
        - Re-submit a request
		- Contact lender 
	    - Request for help
	4. Accepted
		- Contact lender
		- Cancel this request
	    - Request for help
	5. Pending
		- Cancel this request
		- Contact lender

*/

$(document).ready(function(){
	$.get("/",(data,function))
})
