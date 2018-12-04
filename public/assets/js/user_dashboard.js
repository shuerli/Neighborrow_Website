$(document).ready(function() {
  $.get("/userdashboard_initialize", function(data) {
    if (data.status === 404) window.location("/404");
    else if (data.status === 403) window.location("/login");

		
		let final_credit = 0;
		if (data.credit===null || data.credit===undefined || isNaN(data.credit)) {
      final_credit = 0;
		}
		else{
			final_credit = data.credit;
		}

		document.getElementById("main_credit").innerText = final_credit;
		
		$("#dashboard-username").text(data.display_name)
    if (data.borrower_rate === null || data.borrower_rate === undefined)
      $("#main_rateBorrow").text("-");
    else $("#main_rateBorrow").text(Number(data.borrower_rate).toFixed(2));

    if (data.lender_rate === null || data.lender_rate === undefined)
      $("#main_rateLend").text("-");
    else $("#main_rateLend").text(Number(data.lender_rate).toFixed(2));

    if (data.lended_item === null || data.lended_item.length === 0) {
      $("#lended_items_section").empty();
      $("#lended_items_section").append(
        '<div class="col-md-12"><h5 class="text-muted text-center">No items lended</h5></div>'
      );
    } else {
      $("#lended_items_section").empty();
      for (let i = 0; i < data.lended_item.length; i++) {
        let eta_date = "";
        if (moment().isSameOrBefore(data.lended_item[i].endDate))
          eta_date =
            'Should be returned in <a class="text-info">' +
            Math.abs(moment().diff(data.lended_item[i].endDate, "days")) +
            "</a>";
        else
          eta_date =
            'Overdue: <a class="text-danger">' +
            Math.abs(moment().diff(data.lended_item[i].endDate, "days")) +
            " ago</a>";

        $("#lended_items_section").append(
          '<div class="col-md-12"><div class="card"><div class="card-body"style="padding-top: 10px;padding-bottom: 10px;' +
            +'"><div style="line-height: 1.5em;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 100%;font-weight: bold">' +
            data.lended_item[i].itemName +
            '</div><label class="text-muted">Borrowed by ' +
            data.lended_item[i].borrowerName +
            '</label><br><strong class="text-primary"' +
            ">" +
            eta_date +
            "</strong></div></div></div>"
        );
      }
    }

    if (data.borrowed_item === null || data.borrowed_item.length === 0) {
      $("#borrowed_items_section").empty();
      $("#borrowed_items_section").append(
        '<div class="col-md-12"><h5 class="text-muted text-center">No items borrowed</h5></div>'
      );
    } else {
      $("#borrowed_items_section").empty();
      for (let i = 0; i < data.borrowed_item.length; i++) {
        let eta_date = "";
        if (moment().isSameOrBefore(data.borrowed_item[i].endDate))
          eta_date =
            'Should be returned in <a class="text-info">' +
            Math.abs(moment().diff(data.borrowed_item[i].endDate, "days")) +
            "</a>";
        else
          eta_date =
            'Overdue: <a class="text-danger">' +
            Math.abs(moment().diff(data.borrowed_item[i].endDate, "days")) +
            " ago</a>";

        $("#borrowed_items_section").append(
          '<div class="col-md-12"><div class="card"><div class="card-body"style="padding-top: 10px;padding-bottom: 10px;' +
            +'"><div style="line-height: 1.5em;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 100%;font-weight: bold">' +
            data.borrowed_item[i].itemName +
            '</div><label class="text-muted">Borrowed by ' +
            data.borrowed_item[i].lenderName +
            '</label><br><strong class="text-primary"' +
            ">" +
            eta_date +
            "</strong></div></div></div>"
        );
      }
    }

		console.log(data)

    if (data.pending_request === null || data.pending_request.length === 0) {
      $("#pending_requests_section").empty();
      $("#pending_requests_section").append(
        '<div class="col-md-12"><h5 class="text-muted text-center">No new requests in need of approval</h5></div>'
      );
    } else {
      $("#pending_requests_section").empty();
      for (let i = 0; i < data.pending_request.length; i++) {
        $("#pending_requests_section").append(
          '<div class="col-12"><div class="card"><div class="card-body row p-0 d-flex align-items-center">' +
            '<div class="col-8"><div class="text-value-sm text-dark ml-3" style="line-height: 1.5em;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 100%;">' +
            '<a href="/request_lended">' +
            data.pending_request[i].borrowerName +
            ' wants to borrow "' +
            data.pending_request[i].itemName +
            '"</a>' +
            '</div><div class="text-muted text-uppercase font-weight-bold small ml-3" style="line-height: 1.5em;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;width: 100%;"' +
            ">From " +
            moment(data.pending_request[i].startDate).format("MMMM D, YYYY") +
            " to " +
            moment(data.pending_request[i].endDate).format("MMMM D, YYYY") +
            '</div></div><div class="col-4"><i style="cursor: pointer" onclick="accept_request(' +
            data.pending_request[i].requestID +
            ')"class="fa fa-check-circle bg-success p-4 font-2xl ml-3 pull-right"' +
            "></i></div></div></div></div>"
        );
      }
    }
  });
});

let accept_request = request_id => {
  $.ajax({
    url: "/request",
    method: "PUT",
    data: {
      authenticity_token: window._token,
      id: request_id,
      type: "accept"
    }
  }).done(function(data) {
    window.location = "/request_lended";
  });
};
