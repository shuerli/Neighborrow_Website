// Global Variable
let filter_switch = false;


$("#filter_init").click(function () {
	if (!filter_switch) {
		$("#filter_init").removeClass("btn-outline-info");
		$("#filter_init").addClass("btn-outline-danger");
		$("#filter_init").html("Clear Filters");
		$("#filter_section").show();
		filter_switch = true;
	}
	else {
		$("#filter_init").removeClass("btn-outline-danger");
		$("#filter_init").addClass("btn-outline-info");
		$("#filter_init").html("More Filters");
		$("#filter_section").hide();
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
	$.get("/request?type=borrowed&range=all&sorted_by=update_time",(data) => {
		if(data.status===404)
			window.location("/404");
		else if(data.status===403)
			window.location('/login');
		else
			appendSection(data);
	});
})

let appendSection = (info) => {
	$("#list_section").empty();
	info.result.forEach((request)=>{
		let status_span = status_check(request.status);


		let review_section = ""
		if(request.status==='completed'){
			let feedbackToBorrower = info.feedbackToBorrower.filter(x=>x.request_id===request.id)
			let feedbackToBorrower_section = ""
			if(feedbackToBorrower.length===1){
				feedbackToBorrower_section = '<i class="fa fa-star"></i>'.repeat(parseInt(feedbackToBorrower[0].rate))+'<br /> <a id="borrower_comment">'+feedbackToBorrower[0].comment+'</a>'
			}
			else{
				feedbackToBorrower_section = '<strong class="text-muted">Lender hasn\'t provided any feedback yet</strong>';
			}
			let feedbackToLender = info.feedbackToLender.filter(x=>x.request_id===request.id)
			let feedbackToLender_section = ""
				if(feedbackToLender.length===1){
					feedbackToLender_section = '<i class="fa fa-star"></i>'.repeat(parseInt(feedbackToLender[0].rate))+'<br /> <a id="borrower_comment">'+feedbackToLender[0].comment+'</a>'
				}else{
					feedbackToLender_section = '<strong class="text-muted">You haven\'t provided any feedback yet</strong>';
				}
			review_section= '<dl class="row"> <dt class="col-sm-3">Lender\'s Feedback</dt> '+
				'<dd class="col-sm-9"> '+feedbackToBorrower_section+'</dd> </dl> <dl class="row"> '+
				'<dt class="col-sm-3">Your review</dt> <dd class="col-sm-9">'+ feedbackToLender_section + 
				'</dd> </dl>'
		}

		

		let reason_of_rejection_section = ''
		if(request.status==="rejected" && request.rejected_reason!==null)
			reason_of_rejection_section = '<dl class="row"> <dt class="col-sm-3">Reason of Rejection</dt> <dd class="col-sm-9" id="reason_of_rejection"> '+ request.rejected_reason +' </dd> </dl>';
		
		let button_groups = null;
		
		let photo_url=""
		if(photo_url!==null)
			photo_url = request.photo_url


		let content = '<div class="col-md-12"> <div class="card"> <div class="card-header" style="background-color:white;"> <div class="row"> <div class="col-lg-4 col-sm-6 col-xs-6"> <strong class="text-muted">Request ID</strong><br /> '+
					  '<a id="request_id">'+ request.id +'</a> </div> <div class="col-lg-6 d-md-down-none"> <strong class="text-muted">Date of Request</strong><br /> <a id="date_of_request">'+moment(request.created_at.split(" ")[0]).format('MMMM Do, YYYY')+'</a> </div> '+
					  '<div class="col-lg-2 col-sm-6 col-xs-6"> <strong class="text-muted">Status</strong><br /> <span id="status"></span> '+status_span+'</div> </div> </div> '+
					  '<div class="card-body"> <div class="row"> <div class="col-md-8"> <div class="row"> <div class="col-md-2 text-center"> <img src="'+photo_url+'" alt="Item Photo Unavailable" class="img-thumbnail" style="width:80px;" /> </div> '+
					  '<div class="col-md-10"> <h4 id="item_name">'+ request.name +'</h4> <h6 class="text-muted">Owned by <a id="user_name">'+ info.lenders.filter(x=>x.request_id===request.id)[0].display_name +'</a></h6> <small ><a href="https://www.google.ca/" >View Item Detail</a ></small > | <small ><a href="https://www.google.ca/" >View Lender Profile</a ></small > </div> </div> '+
					  '<hr /> <div class="row"> <div class="col-md-12"> <div class="progress-group"> <div class="progress-group-header"> <div> <a class="pull-left">Last Update</a ><br /><strong>Request Approved</strong><br /> <small class="text-muted" >November 11, 2018</small > </div> <div class="ml-auto"> <a class="pull-right">Next Task</a>'+
					  '<br /><strong class="pull-right" >Get your item</strong ><br /><small class="text-muted" >November 11, 2018</small > </div> </div> <div class="progress-group-bars"> <div class="progress"> <div class="progress-bar bg-warning" role="progressbar" style="width: 43%" aria-valuenow="43" aria-valuemin="0" aria-valuemax="100" ></div>'+
					  ' </div> </div> </div></div></div><div class="row" style="margin-top:15px;"> <div class="col-md-6"> <strong>Pick-up Location</strong><br /> <span id="pickup_location"></span> <a>40 St George St</a><br /> <a>Toronto, Ontario</a><br /> <a>M5S 2E4</a><br /> </div> <div class="col-md-6"> <strong>Time Range</strong><br /> '+
					  '<a id="time_range">'+moment(request.time_start).format('MMMM Do, YYYY')+' - '+moment(request.time_end).format('MMMM Do, YYYY')+'</a> </div> <div class="col-md-12"> <br /> '+reason_of_rejection_section+ review_section +'  </div> </div> </div> <div class="col-md-4 text-center" style="border-left: 1px solid grey;" > <button class="btn btn-warning" style="width:65%;margin-bottom: 15px;" > Provide Feedback </button> <button class="btn btn-warning" style="width:65%;margin-bottom: 15px;" disabled > Provide Feedback </button> '+
					  '<button class="btn btn-primary" style="width:65%;margin-bottom: 15px;" > Contact Lender </button> <button class="btn btn-light" style="width:65%;margin-bottom: 15px;" > Request for help </button> <button class="btn btn-danger" style="width:65%;margin-bottom: 15px;" > Cancel this request </button> '+
					  '<button class="btn btn-outline-primary" style="width:65%;margin-bottom: 15px;" > Re-submit this request </button> <button class="btn btn-outline-success" style="width:65%;margin-bottom: 15px;" > Borrow this again </button> </div> </div> </div> </div> </div>';
		$("#list_section").append(content);
	});	
}


let status_check = (status)=>{
	switch(status) {
		case "pending":
			return '<a class="text-warning" ><i class="fa fa-hourglass-half"></i> Pending</a >'
			break;
		case "accepted":
			return '<a class="text-primary" ><i class="fa fa-check-circle"></i> Accepted</a >'
			break;
		case "completed":
			return '<a class="text-success" ><i class="fa fa-star"></i> Completed</a >'
			break;
		case "rejected":
			return '<a class="text-danger" ><i class="fa fa-times-circle"></i> Rejected</a >'
			break;
		case "cancelled":
			return '<a class="text-dark" ><i class="fa fa-trash"></i> Cancelled</a >'
			break;
	}
	
}
