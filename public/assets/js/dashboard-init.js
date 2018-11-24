$(function() {
  $("#headerModule").load("../../modules/header.html");
  $("#menuModule").load("../../modules/menu.html");
  $("#subHeaderModule").load("../../modules/subheader.html");
  $("#footerModule").load("../../modules/footer.html");

  //Initialize the user info in the side bar
  $.get("/sidebar_intialize", function(data) {
    if (data.status === 404) window.location("/404");
	else if (data.status === 403) window.location("/login");

	
	$("#name_display_section").text(data.display_name);
	if(data.borrower_credit===null){
		data.borrower_credit = 0;
	}
	if(data.lender_credit===null){
		data.lender_credit = 0;
	}
	if(data.borrower_rate===null){
		data.borrower_rate = "-";
	}

	
	$("#credit_display_section").text(data.borrower_credit+data.lender_credit);
	$("#rate_display_section").text(data.borrower_rate);
  });
});
