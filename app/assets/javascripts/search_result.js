let condition_pill = {
	"Brand New":
	  '<span class="badge badge-success" style="position:absolute;z-index:100;right:10px;top:10px;">Brand New</span>',
	"Like New":
	  '<span class="badge badge-primary" style="position:absolute;z-index:100;right:10px;top:10px;">Like New</span>',
	"Very Good":
	  '<span class="badge badge-info" style="position:absolute;z-index:100;right:10px;top:10px;"></span>',
	Good:
	  '<span class="badge badge-warning" style="position:absolute;z-index:100;right:10px;top:10px;">Like New</span>',
	Adequate:
	  '<span class="badge badge-light" style="position:absolute;z-index:100;right:10px;top:10px;">Like New</span>',
	Defective:
	  '<span class="badge badge-dark" style="position:absolute;z-index:100;right:10px;top:10px;">Like New</span>'
  };
  
  $(document).ready(function() {
  
	  document.getElementById("itemISBN_section").style.display = "None";
	  document.getElementById("itemNameBrand_section").style.display = "None";
	  document.getElementById("corrected_results_section").style.display = "None";
	  document.getElementById("no_results_section").style.display = "None";
	let urlObj = new URL(window.location.href);
	let keyword = urlObj.searchParams.get("keyword");
	let location = urlObj.searchParams.get("location");
	fetch("/result_api?keyword=" + keyword + "&location=" + location)
	  .then(response => {
		return response.json();
	  })
	  .then(data => {
		console.log(data);
		if (data.result_userEmail.result !== null) {
		  if (data.result_userEmail.result.length !== 0) {
			  user_render(data.result_userEmail);
		  } 
		}
		
		/*else if (data.result_userName !== null) {
		  if (data.result_userName.length !== 0)
			user_render(data.result_userName[0]);
		}*/ else document.getElementById("user_section").style.display = "none";
		
		item_render(data);
	  });
  });
  
  let user_render = userBlock => {
	  document.getElementById("suggested_user_name").innerText = userBlock.result[0].display_name;
	  document.getElementById("user_card").onclick = () => {
		  window.location = "/user/profile/"+userBlock.result[0].id;
	  }
	  if(userBlock.borrowRate[0].borrow_rate!==null)
		  document.getElementById("suggest_user_borrow_rate").innerText = userBlock.borrowRate[0].borrow_rate.toFixed(2);
	  else
		  document.getElementById("suggest_user_borrow_rate").innerText = "None";
		  if(userBlock.lendRate[0].lend_rate!==null)
		  document.getElementById("suggest_user_lend_rate").innerText = userBlock.lendRate[0].lend_rate.toFixed(2);
	  else
		  document.getElementById("suggest_user_lend_rate").innerText = "None";
  
	  if(userBlock.result[0].gender == "Male")
		  document.getElementById("suggested_user_gender").innerHTML = '<i class="fa fa-mars text-primary" aria-hidden="true"></i>';
	  else if(userBlock.result[0].gender == "Female")
		  document.getElementById("suggested_user_gender").innerHTML = '<i class="fa fa-mars text-danger" aria-hidden="true"></i>';
	  else
		  document.getElementById("suggested_user_gender").innerHTML = "";
  
	  document.getElementById("user_section").style.display = "";
  };
  
  let item_render = itemList => {
  
	  let totalCount = 0;
	  if(itemList.result_itemISBN!==null&&itemList.result_itemISBN!==undefined){
		  document.getElementById("isbn_result_length").innerText = itemList.result_itemISBN.length;
		  document.getElementById("isbn_keyword").innerText = itemList.search_keyword;
		  for(let i = 0; i < itemList.result_itemISBN.length; i++){
			  document.getElementById("itemISBN_section").innerHTML += '<div class="col-md-3 col-sm-6"><div class="card"><span class="item_detail_span" style="cursor:pointer" onclick="location.href = \'/items/'+itemList.result_itemISBN[i].itemID+'\'"><img class="card-img-top" style="width:100%;" src="'+itemList.result_itemISBN[i].itemPhoto+'" alt="Card image cap"/>'+
			  condition_pill[itemList.result_itemISBN[i].itemCondition]+'<div class="card-body" style="padding-left: 10px;padding-bottom: 10px;padding-top: 10px;"><div style="line-height: 1.5em; height: 3em;overflow: hidden;"><strong class="card-title text-secondary">'+
			  itemList.result_itemISBN[i].name+'</strong></div><small class="text-dark"><u>Borrowed by x users</u></small></div><hr style="margin-top:0;margin-bottom:0;" /></span><div class="card-body user_detail_span" style="cursor: pointer;padding-left: 10px;padding-bottom: 2px;padding-top: 5px;">'+
			  '<span><img class="img-thumbnail" style="width:30px; border-radius: 50%; padding-top:0; padding-bottom:0; padding-left:0; padding-right:0;" src="'+itemList.result_itemISBN[i].ownerPhoto+'"/>&nbsp; <label class="text-muted">'+itemList.result_itemISBN[i].ownerName+'</label>'+
				  '<label class="pull-right text-warning" style="margin-top:1.5px;"><i class="fa fa-star"></i> x</label></span></div></div></div>'
			  totalCount++;
		  }
		  totalCount++;
		  document.getElementById("itemISBN_section").style.display = "";
	  }
	  if(itemList.result_itemNameBrand.length!==0&&itemList.result_itemNameBrand!==null&&itemList.result_itemNameBrand!==undefined){
		  document.getElementById("namebrand_result_count").innerText = itemList.result_itemNameBrand.length;
		  document.getElementById("namebrand_keyword").innerText = itemList.search_keyword;
		  for(let i = 0; i < itemList.result_itemNameBrand.length; i++){
			  document.getElementById("itemNameBrand_section").innerHTML += '<div class="col-md-3 col-sm-6"><div class="card"><span class="item_detail_span" style="cursor:pointer" onclick="location.href = \'/items/'+itemList.result_itemNameBrand[i].itemID+'\'"><img class="card-img-top" style="width:100%;" src="'+itemList.result_itemNameBrand[i].itemPhoto+'" alt="Card image cap"/>'+
			  condition_pill[itemList.result_itemNameBrand[i].itemCondition]+'<div class="card-body" style="padding-left: 10px;padding-bottom: 10px;padding-top: 10px;"><div style="line-height: 1.5em; height: 3em;overflow: hidden;"><strong class="card-title text-secondary">'+
			  itemList.result_itemNameBrand[i].name+'</strong></div><small class="text-dark"><u>Borrowed by x users</u></small></div><hr style="margin-top:0;margin-bottom:0;" /></span><div class="card-body user_detail_span" style="cursor: pointer;padding-left: 10px;padding-bottom: 2px;padding-top: 5px;">'+
			  '<span><img class="img-thumbnail" style="width:30px; border-radius: 50%; padding-top:0; padding-bottom:0; padding-left:0; padding-right:0;" src="'+itemList.result_itemNameBrand[i].ownerPhoto+'"/>&nbsp; <label class="text-muted">'+itemList.result_itemNameBrand[i].ownerName+'</label>'+
				  '<label class="pull-right text-warning" style="margin-top:1.5px;"><i class="fa fa-star"></i> x</label></span></div></div></div>'
			  totalCount++;
		  }
		  document.getElementById("itemNameBrand_section").style.display = "";
	  }
	  if(totalCount===0){
		  if(itemList.result_correctedKeyword!==null&&itemList.result_correctedKeyword!==undefined&&itemList.corrected_keyword!==""&&itemList.corrected_keyword!==null){
			  document.getElementById("original_keyword").innerText = itemList.search_keyword;
			  document.getElementById("corrected_keyword_results_count").innerText = itemList.result_correctedKeyword.length;
			  document.getElementById("corrected_keyword").innerText = itemList.corrected_keyword;
			  for(let i = 0; i < itemList.result_correctedKeyword.length; i++){
				  document.getElementById("itemNameBrand_section").innerHTML += '<div class="col-md-3 col-sm-6"><div class="card"><span class="item_detail_span" style="cursor:pointer" onclick="location.href = \'/items/'+itemList.result_correctedKeyword[i].itemID+'\'"><img class="card-img-top" style="width:100%;" src="'+itemList.result_correctedKeyword[i].itemPhoto+'" alt="Card image cap"/>'+
				  condition_pill[itemList.result_correctedKeyword[i].itemCondition]+'<div class="card-body" style="padding-left: 10px;padding-bottom: 10px;padding-top: 10px;"><div style="line-height: 1.5em; height: 3em;overflow: hidden;"><strong class="card-title text-secondary">'+
				  itemList.result_correctedKeyword[i].name+'</strong></div><small class="text-dark"><u>Borrowed by x users</u></small></div><hr style="margin-top:0;margin-bottom:0;" /></span><div class="card-body user_detail_span" style="cursor: pointer;padding-left: 10px;padding-bottom: 2px;padding-top: 5px;">'+
				  '<span><img class="img-thumbnail" style="width:30px; border-radius: 50%; padding-top:0; padding-bottom:0; padding-left:0; padding-right:0;" src="'+itemList.result_correctedKeyword[i].ownerPhoto+'"/>&nbsp; <label class="text-muted">'+itemList.result_correctedKeyword[i].ownerName+'</label>'+
					  '<label class="pull-right text-warning" style="margin-top:1.5px;"><i class="fa fa-star"></i> x</label></span></div></div></div>'
				  totalCount++;
			  }
			  document.getElementById("corrected_results_section").style.display = "";
		  }
		  else{
			  document.getElementById("keyword_no_results").innerText = itemList.search_keyword;
			  document.getElementById("no_results_section").style.display = "";
		  }
	  }
  };
  