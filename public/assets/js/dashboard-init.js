$(function() {
	$("#subHeaderModule").load("../../modules/subheader.html");
  $("#headerModule").load("../../modules/header.html");
  $("#menuModule").load("../../modules/menu.html");
  $("#footerModule").load("../../modules/footer.html");

  //Initialize the user info in the side bar
  $.get("/sidebar_intialize", function(data) {
    if (data.status === 404) window.location("/404");
	else if (data.status === 403) window.location("/login");

	$("#menu_profile_href").attr("href","/profiles/"+data.id)

	$("#user_image_display").attr("src",data.display_photo);
	
	$("#name_display_section").text(data.display_name);
	if(data.borrower_credit===null){
		data.borrower_credit = 0;
	}
	if(data.lender_credit===null){
		data.lender_credit = 0;
	}

	if(data.borrower_rate===null||data.borrower_rate===undefined)
			$("#rate_display_section").text("-");
		else
			$("#rate_display_section").text(Number(data.borrower_rate).toFixed(1));
			
	$("#credit_display_section").text(data.borrower_credit+data.lender_credit);
  });
});
