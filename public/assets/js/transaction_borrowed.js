// Global Variable
let filter_switch = false;
let filterOut_status = {
  pending: false,
  accepted: false,
  rejected: false,
  cancelled: false,
  completed: false
};
let filter_range = "all";
let cache = null;

$("#filter_init").click(function() {
  if (!filter_switch) {
    $("#filter_init").removeClass("btn-outline-info");
    $("#filter_init").addClass("btn-outline-danger");
    $("#filter_init").html("Clear Filters");
    $("#filter_section").show();
    filter_switch = true;
  } else {
    $("#filter_init").removeClass("btn-outline-danger");
    $("#filter_init").addClass("btn-outline-info");
    $("#filter_init").html("More Filters");
    $("#filter_section").hide();
    filter_switch = false;
  }
});

$(document).ready(function() {
  $.get("/request?type=borrowed&range=all&sorted_by=update_time", data => {
		console.log(data)
    cache = data;
    if (data.status === 404) window.location("/404");
    else if (data.status === 403) window.location("/login");
    else appendSection(data);
  });
});

let appendSection = info => {
  $("#list_section").empty();
  info.result.forEach(request => {
    // Cache every requests into a specific category based on their status
    if (filterOut_status[request.status]) return;

    // Apply the filter of date range on each request
    if (filter_range === "1month") {
      if (moment(request.created_at).isBefore(moment().subtract(1, "month")))
        return;
    } else if (filter_range === "3month") {
      if (moment(request.created_at).isBefore(moment().subtract(3, "month")))
        return;
    } else if (filter_range === "6month") {
      if (moment(request.created_at).isBefore(moment().subtract(6, "month")))
        return;
    } else if (filter_range === "1year") {
      if (moment(request.created_at).isBefore(moment().subtract(1, "year")))
        return;
    }

    // Handling the display of status section
    let status_span = status_check(request.status);

    // Handling the display of lender's and borrower's review and feedback
    // Only display when the status is "completed"
    let review_section = "";
    if (request.status === "completed") {
      let feedbackToBorrower = info.feedbackToBorrower.filter(
        x => x.request_id === request.id
      );
      let feedbackToBorrower_section = "";
      if (feedbackToBorrower.length === 1) {
        feedbackToBorrower_section =
          '<i class="fa fa-star"></i>'.repeat(
            parseInt(feedbackToBorrower[0].rate)
          ) +
          '<br /> <a id="borrower_comment">' +
          feedbackToBorrower[0].comment +
          "</a>";
      } else {
        feedbackToBorrower_section =
          '<strong class="text-muted">Lender hasn\'t provided any feedback yet</strong>';
      }
      let feedbackToLender = info.feedbackToLender.filter(
        x => x.request_id === request.id
      );
      let feedbackToLender_section = "";
      if (feedbackToLender.length === 1) {
        feedbackToLender_section =
          '<i class="fa fa-star"></i>'.repeat(
            parseInt(feedbackToLender[0].rate)
          ) +
          '<br /> <a id="borrower_comment">' +
          feedbackToLender[0].comment +
          "</a>";
      } else {
        feedbackToLender_section =
          '<strong class="text-muted">You haven\'t provided any feedback yet</strong>';
      }
      review_section =
        '<dl class="row"> <dt class="col-sm-3">Lender\'s Feedback</dt> ' +
        '<dd class="col-sm-9"> ' +
        feedbackToBorrower_section +
        '</dd> </dl> <dl class="row"> ' +
        '<dt class="col-sm-3">Your review</dt> <dd class="col-sm-9">' +
        feedbackToLender_section +
        "</dd> </dl>";
    }

    // Handling the display of the reason of request rejection
    // Only display when the request is rejected
    let reason_of_rejection_section = "";
    if (request.status === "rejected" && request.rejected_reason !== null)
      reason_of_rejection_section =
        '<dl class="row"> <dt class="col-sm-3">Reason of Rejection</dt> <dd class="col-sm-9" id="reason_of_rejection"> ' +
        request.rejected_reason +
        " </dd> </dl>";

    // Handling the display of the item image
    // An alternative image for item without photos in need
    let photo_url = "";
    if (photo_url !== null) photo_url = request.photo_url;

    // Handling the display of progressbar section
    /*
		Progressbar status:
			1. Completed
				-	Last update: item returned
				-	If feedback_to_lender doesn't exist:
					Next Task: Provide feedback, 95% yellow progress bar
				-	If it exists
					No next task, green 100% progress bar
			2. Cancelled
				-	grey progress bar
				-	Last update: request cancelled
			3. Rejected
				-	Grey progress bar
				-	Last update: request rejected
			4. Accepted
				-	Last update: request has been accepted
				-	Item hasn't beed delievered
					-	Get your item, 35% progress bar
				-	Item hasn't been returned
					-	Return the item upon request, 75% progress bar
			5. Pending
				-	15% Progress bar
				-	Last update: request submitted
				-	Next Task: waiting for approval
	*/

    // This entry is fixed
    let progressbar_last_update_date = moment(request.updated_at).format(
      "MMMM Do, YYYY"
    );

    let progressbar_percentage = "";
    let progressbar_color = "";
    let progressbar_last_update_task = "";
    let progressbar_next_task =
      '<a class="pull-right">Next Task</a><br /><strong class="pull-right" >Get your item</strong >';
    let progressbar_next_date =
      '<br /><small class="text-muted" >November 11, 2018</small >';

    switch (request.status) {
      case "pending":
        progressbar_percentage = "15";
        progressbar_color = "bg-info";
        progressbar_last_update_task = "Request Submitted";
        progressbar_next_task =
          '<a class="pull-right">Next Task</a><br /><strong class="pull-right" >Waiting for Approval</strong >';
        progressbar_next_date = "";
        break;
      case "accepted":
        if (
          //moment(request.time_start).isSameOrAfter(moment().format()) &&
          //moment(request.time_end).isSameOrAfter(moment().format()) &&
          !request.received &&
          !request.returned
        ) {
          progressbar_percentage = "45";
          progressbar_color = "bg-info";
          progressbar_last_update_task = "Request Accepted";
          progressbar_next_task =
            '<a class="pull-right">Next Task</a><br /><strong class="pull-right" >Get This Item</strong >';
          progressbar_next_date =
            '<br /><small class="text-muted" >Before or On ' +
            moment(request.time_start).format("MMMM Do, YYYY") +
            "</small >";
        } else if (
          //moment(request.time_start).isSameOrBefore(moment().format()) &&
          //moment(request.time_end).isSameOrAfter(moment().format()) &&
          request.received &&
          !request.returned
        ) {
          progressbar_percentage = "70";
          progressbar_color = "bg-info";
          progressbar_last_update_task = "Item Received";
          progressbar_next_task =
            '<a class="pull-right">Next Task</a><br /><strong class="pull-right" >Return This Item</strong >';
          progressbar_next_date =
            '<br /><small class="text-muted" >Before or On ' +
            moment(request.time_end).format("MMMM Do, YYYY") +
            "</small >";
        }
        break;
      case "completed":
        if (
          info.feedbackToLender.filter(x => x.request_id === request.id)
            .length === 1
        ) {
          progressbar_percentage = "100";
          progressbar_color = "bg-success";
          progressbar_last_update_task = "Feedback Submitted";
          progressbar_next_task = "";
          progressbar_next_date = "";
        } else {
          progressbar_percentage = "95";
          progressbar_color = "bg-warning";
          progressbar_last_update_task = "Item Returned";
          progressbar_next_task =
            '<a class="pull-right">Next Task</a><br /><strong class="pull-right" >Provide Your Feedback</strong >';
          progressbar_next_date = "";
        }
        break;
      case "rejected":
        progressbar_percentage = "100";
        progressbar_color = "bg-secondary";
        progressbar_last_update_task = "Request Rejected";
        progressbar_next_task = "";
        progressbar_next_date = "";
        break;
      case "cancelled":
        progressbar_percentage = "100";
        progressbar_color = "bg-secondary";
        progressbar_last_update_task = "Request Cancelled";
        progressbar_next_task = "";
        progressbar_next_date = "";
        break;
    }
    let progressbar_section =
      '<div class="row"> <div class="col-md-12"> <div class="progress-group"> <div class="progress-group-header"> <div> <a class="pull-left">Last Update</a ><br /><strong>' +
      progressbar_last_update_task +
      '</strong><br /> <small class="text-muted" >' +
      progressbar_last_update_date +
      '</small > </div> <div class="ml-auto">' +
      progressbar_next_task +
      progressbar_next_date +
      '</div> </div> <div class="progress-group-bars"> <div class="progress"> <div class="progress-bar ' +
      progressbar_color +
      '" role="progressbar" style="width: ' +
      progressbar_percentage +
      '%" aria-valuenow="' +
      progressbar_percentage +
      '" aria-valuemin="0" aria-valuemax="100" ></div>' +
      " </div> </div> </div></div></div>";

    // Handling the display of button sections
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

			* "Re-submit" & "Borrow this again" are dealt by the same handler
		*/
    let button_section = "",
      cancel_button = "",
      contact_button = "",
      help_button = "",
      feedback_button = "",
      resubmit_button = "";
    received_button = "";
    switch (request.status) {
      case "pending":
        cancel_button =
          '<button class="btn btn-danger" style="width:65%;margin-bottom: 15px;" onclick="cancel_request(' +
          request.id +
          ')"> Cancel This Request </button>';
        contact_button =
          '<a href="mailto:' +
          info.lenders.filter(x => x.request_id === request.id)[0].email +
          '"><button class="btn btn-primary" style="width:65%;margin-bottom: 15px;" > Contact Lender </button></a>';
        button_section = contact_button + cancel_button;
        //+'<button class="btn btn-warning" style="width:65%;margin-bottom: 15px;" onclick="provide_feedback(' +request.id +')" > Provide Feedback </button>';
        break;
      case "accepted":
        if (!request.received)
          received_button =
            '<button class="btn btn-success" style="width:65%;margin-bottom: 15px;" onclick="receive_item(' +
            request.id +
            ')"> Item Received </button>';
        help_button =
          '<button class="btn btn-light" style="width:65%;margin-bottom: 15px;" > Request for help </button>';
        cancel_button =
          '<button class="btn btn-danger" style="width:65%;margin-bottom: 15px;" onclick="cancel_request(' +
          request.id +
          ')"> Cancel This Request </button>';
        contact_button =
          '<a href="mailto:' +
          info.lenders.filter(x => x.request_id === request.id)[0].email +
          '"><button class="btn btn-primary" style="width:65%;margin-bottom: 15px;" > Contact Lender </button></a>';
        if (!request.received)
          button_section =
            received_button + contact_button + cancel_button + help_button;
        else
          button_section =
            received_button + contact_button + cancel_button + help_button;
        break;
      case "completed":
        if (
          info.feedbackToLender.filter(x => x.request_id === request.id)
            .length === 0
        ) {
          feedback_button =
            '<button class="btn btn-warning" style="width:65%;margin-bottom: 15px;" onclick="provide_feedback(' +
            request.id +
            ')" > Provide Feedback </button>';
        }
        contact_button =
          '<a href="mailto:' +
          info.lenders.filter(x => x.request_id === request.id)[0].email +
          '"><button class="btn btn-primary" style="width:65%;margin-bottom: 15px;" > Contact Lender </button></a>';
        button_section = feedback_button + contact_button;
        break;
      case "rejected":
        resubmit_button =
          '<a href="/"><button class="btn btn-outline-primary" style="width:65%;margin-bottom: 15px;" > Re-submit this request </button></a>';
        help_button =
          '<button class="btn btn-light" style="width:65%;margin-bottom: 15px;" > Request for help </button>';
        contact_button =
          '<a href="mailto:' +
          info.lenders.filter(x => x.request_id === request.id)[0].email +
          '"><button class="btn btn-primary" style="width:65%;margin-bottom: 15px;" > Contact Lender </button></a>';
        button_section = contact_button + help_button + resubmit_button;
        break;
      case "cancelled":
        resubmit_button =
          '<a href="/"><button class="btn btn-outline-primary" style="width:65%;margin-bottom: 15px;" > Re-submit this request </button></a>';
        contact_button =
          '<a href="mailto:' +
          info.lenders.filter(x => x.request_id === request.id)[0].email +
          '"><button class="btn btn-primary" style="width:65%;margin-bottom: 15px;" > Contact Lender </button></a>';
        button_section = contact_button + resubmit_button;
        break;
    }

    // Handling the display of pick-up location
    let address = info.addresses.filter(x => x.request_id === request.id);
    let address_section = "";
    if (address.length === 0) {
      address_section =
        "<a>Please contact the lender for this information.</a>";
    } else {
      address_section =
        "<a>" +
        address[0].address_line1 +
        "</a><br /> <a>" +
        address[0].address_line2 +
        "</a><br /><a>" +
        address[0].city +
        ", " +
        address[0].province +
        "</a><br /> <a>" +
        address[0].postal_code +
        "</a><br />";
    }

    let content =
      '<div class="col-md-12"> <div class="card"> <div class="card-header" style="background-color:white;"> <div class="row"> <div class="col-lg-4 col-sm-6 col-xs-6"> <strong class="text-muted">Request ID</strong><br /> ' +
      '<a id="request_id">' +
      request.id +
      '</a> </div> <div class="col-lg-6 d-md-down-none"> <strong class="text-muted">Date of Request</strong><br /> <a id="date_of_request">' +
      moment(request.created_at.split(" ")[0]).format("MMMM Do, YYYY") +
      "</a> </div> " +
      '<div class="col-lg-2 col-sm-6 col-xs-6"> <strong class="text-muted">Status</strong><br /> <span id="status"></span> ' +
      status_span +
      "</div> </div> </div> " +
      '<div class="card-body"> <div class="row"> <div class="col-md-8"> <div class="row"> <div class="col-md-2 text-center"> <img src="' +
      photo_url +
      '" alt="Item Photo Unavailable" class="img-thumbnail" style="width:80px;" /> </div> ' +
      '<div class="col-md-10"> <h4 id="item_name">' +
      request.name +
      '</h4> <h6 class="text-muted">Owned by <a id="user_name">' +
      info.lenders.filter(x => x.request_id === request.id)[0].display_name +
      '</a></h6> <small ><a href="https://www.google.ca/" >View Item Detail</a ></small > | <small ><a href="https://www.google.ca/" >View Lender Profile</a ></small > </div> </div> ' +
      "<hr />" +
      progressbar_section +
      '<div class="row" style="margin-top:15px;"> <div class="col-md-6"> <strong>Pick-up Location</strong><br /> <span id="pickup_location"></span> ' +
      address_section +
      ' </div> <div class="col-md-6"> <strong>Time Range</strong><br /> ' +
      '<a id="time_range">' +
      moment(request.time_start).format("MMMM Do, YYYY") +
      " - " +
      moment(request.time_end).format("MMMM Do, YYYY") +
      '</a> </div> <div class="col-md-12"> <br /> ' +
      reason_of_rejection_section +
      review_section +
      '  </div> </div> </div> <div class="col-md-4 text-center" id="button_area">' +
      button_section +
      "</div> </div> </div> </div> </div>";
    $("#list_section").append(content);
  });
};

let status_check = status => {
  switch (status) {
    case "pending":
      return '<a class="text-info" ><i class="fa fa-hourglass-half"></i> Pending</a >';
      break;
    case "accepted":
      return '<a class="text-primary" ><i class="fa fa-check-circle"></i> Accepted</a >';
      break;
    case "completed":
      return '<a class="text-success" ><i class="fa fa-star"></i> Completed</a >';
      break;
    case "rejected":
      return '<a class="text-danger" ><i class="fa fa-times-circle"></i> Rejected</a >';
      break;
    case "cancelled":
      return '<a class="text-dark" ><i class="fa fa-trash"></i> Cancelled</a >';
      break;
  }
};

let cancel_request = request_id => {
  $("#cancel_confirmed").attr("onclick", "cancel_handler(" + request_id + ")");
  $("#cancel_error_block").hide();
  $("#cancellation_modal").modal("show");
};

let cancel_handler = request_id => {
  $.ajax({
    url: "/request",
    method: "PUT",
    data: {
      authenticity_token: window._token,
      id: request_id,
      type: "cancel"
    }
  })
    .done(function(data) {
      window.location = "/request_borrowed";
    })
    .fail(function(data) {
      $("#cancel_error_block").show();
    });
};

let receive_item = request_id => {
  $.ajax({
    url: "/request",
    method: "PUT",
    data: {
      authenticity_token: window._token,
      id: request_id,
      type: "receive"
    }
  }).done(function(data) {
    window.location = "/request_borrowed";
  });
};

let provide_feedback = request_id => {
  $("#feedback_form").attr("onclick", "feedback_handler(" + request_id + ")");
  $("#feedback_modal").modal("show");
};

let feedback_handler = request_id => {
  //alert($("#feedback_rate option:selected").text());
  //alert($("#feedback_comment").val());
  $.post(
    "/feedback/to-lender",
    {
      authenticity_token: window._token,
      request_id: request_id,
      rate: $("#feedback_rate option:selected").text(),
      comment: $("#feedback_comment").val()
    },
    function(data) {
      window.location = "/request_borrowed";
    }
  );
};

$("#sort_order").on("change", function() {
  $.get("/request?type=borrowed&range=all&sorted_by=" + this.value, data => {
    if (data.status === 404) window.location("/404");
    else if (data.status === 403) window.location("/login");
    else appendSection(data);
  });
});

$("#completed_checkbox").on("change", function() {
  if ($(this).is(":checked")) filterOut_status["completed"] = false;
  else filterOut_status["completed"] = true;
  appendSection(cache);
});

$("#pending_checkbox").on("change", function() {
  if ($(this).is(":checked")) filterOut_status["pending"] = false;
  else filterOut_status["pending"] = true;
  appendSection(cache);
});

$("#accepted_checkbox").on("change", function() {
  if ($(this).is(":checked")) filterOut_status["accepted"] = false;
  else filterOut_status["accepted"] = true;
  appendSection(cache);
});

$("#rejected_checkbox").on("change", function() {
  if ($(this).is(":checked")) filterOut_status["rejected"] = false;
  else filterOut_status["rejected"] = true;
  appendSection(cache);
});

$("#cancelled_checkbox").on("change", function() {
  if ($(this).is(":checked")) filterOut_status["cancelled"] = false;
  else filterOut_status["cancelled"] = true;
  appendSection(cache);
});

$("#range_filter").on("change", function() {
  switch (this.value) {
    case "all":
      filter_range = "all";
      appendSection(cache);
      break;
    case "1month":
      filter_range = "1month";
      appendSection(cache);
      break;
    case "3month":
      filter_range = "3month";
      appendSection(cache);
      break;
    case "6month":
      filter_range = "6month";
      appendSection(cache);
      break;
    case "1year":
      filter_range = "1year";
      appendSection(cache);
      break;
  }
});

$("#borrowed_searchbar").keyup(function(event) {
  if (event.keyCode === 13) {
    $("#filter_init").attr("disabled", true);
    $("#sort_order").attr("disabled", true);
    $.get(
      "/request?type=borrowed&range=keyword&keyword=" +
        $("#borrowed_searchbar").val(),
      data => {
        appendSection(data);
      }
    );
  } else if (event.keyCode === 8) {
    if ($("#borrowed_searchbar").val() === "") {
      appendSection(cache);
      $("#filter_init").prop("disabled", false);
      $("#sort_order").prop("disabled", false);
    }
  }
});
