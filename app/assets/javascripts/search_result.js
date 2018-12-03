const condition_pill = {
  "Brand New":
    '<span class="badge badge-success" style="position:absolute;z-index:100;right:10px;top:10px;">Brand New</span>',
  "Like New":
    '<span class="badge badge-primary" style="position:absolute;z-index:100;right:10px;top:10px;">Like New</span>',
  "Very Good":
    '<span class="badge badge-info" style="position:absolute;z-index:100;right:10px;top:10px;color: white;">Very Good</span>',
  Good:
    '<span class="badge badge-warning" style="position:absolute;z-index:100;right:10px;top:10px;">Good</span>',
  Adequate:
    '<span class="badge badge-light" style="position:absolute;z-index:100;right:10px;top:10px;">Adequate</span>',
  Defective:
    '<span class="badge badge-dark" style="position:absolute;z-index:100;right:10px;top:10px;">Defective</span>'
};

const state_lookup = {
  AL: "Alabama",
  AK: "Alaska",
  AS: "American Samoa",
  AZ: "Arizona",
  AR: "Arkansas",
  CA: "California",
  CO: "Colorado",
  CT: "Connecticut",
  DE: "Delaware",
  DC: "District Of Columbia",
  FM: "Federated States Of Micronesia",
  FL: "Florida",
  GA: "Georgia",
  GU: "Guam",
  HI: "Hawaii",
  ID: "Idaho",
  IL: "Illinois",
  IN: "Indiana",
  IA: "Iowa",
  KS: "Kansas",
  KY: "Kentucky",
  LA: "Louisiana",
  ME: "Maine",
  MH: "Marshall Islands",
  MD: "Maryland",
  MA: "Massachusetts",
  MI: "Michigan",
  MN: "Minnesota",
  MS: "Mississippi",
  MO: "Missouri",
  MT: "Montana",
  NE: "Nebraska",
  NV: "Nevada",
  NH: "New Hampshire",
  NJ: "New Jersey",
  NM: "New Mexico",
  NY: "New York",
  NC: "North Carolina",
  ND: "North Dakota",
  MP: "Northern Mariana Islands",
  OH: "Ohio",
  OK: "Oklahoma",
  OR: "Oregon",
  PW: "Palau",
  PA: "Pennsylvania",
  PR: "Puerto Rico",
  RI: "Rhode Island",
  SC: "South Carolina",
  SD: "South Dakota",
  TN: "Tennessee",
  TX: "Texas",
  UT: "Utah",
  VT: "Vermont",
  VI: "Virgin Islands",
  VA: "Virginia",
  WA: "Washington",
  WV: "West Virginia",
  WI: "Wisconsin",
  WY: "Wyoming",
  AB: "Alberta",
  BC: "British Columbia",
  MB: "Manitoba",
  NB: "New Brunswick",
  NL: "Newfoundland and Labrador",
  NT: "Northwest Territories",
  NS: "Nova Scotia",
  NU: "Nunavut",
  ON: "Ontario",
  PE: "Prince Edward Island",
  QC: "Quebec",
  SK: "Saskatchewan",
  YT: "Yukon Territory"
};

let filterOut_status = {
  "Brand New": false,
  "Like New": false,
  "Very Good": false,
  Good: false,
  Adequate: false,
  Defective: false
};

let postcode_lock = false;
let postcode_current = null;

let cache = null;

$(document).ready(function() {
  document.getElementById("itemISBN_section").style.display = "None";
  document.getElementById("itemNameBrand_section").style.display = "None";
  document.getElementById("corrected_results_section").style.display = "None";
  document.getElementById("no_results_section").style.display = "None";
  let urlObj = new URL(window.location.href);
  let keyword = urlObj.searchParams.get("keyword");
  let city = urlObj.searchParams.get("city");
  let country = urlObj.searchParams.get("country");
  let province = urlObj.searchParams.get("province");
  if (country === "USA" || country === "Canada") {
    province = state_lookup[urlObj.searchParams.get("province")];
  }

  fetch(
    "/result_api?keyword=" +
      keyword +
      "&city=" +
      city +
      "&province=" +
      province +
      "&country=" +
      country
  )
    .then(response => {
      return response.json();
    })
    .then(data => {
			console.log(data);
			cache = data;
      document.getElementById("current_city").innerText = data.given_city;
      document.getElementById("current_province").innerText =
        data.given_province;
      document.getElementById("current_country").innerText = data.given_country;
      if (data.result_userEmail.result !== null) {
        if (data.result_userEmail.result.length !== 0) {
          user_render(data.result_userEmail);
        }
      } else document.getElementById("user_section").style.display = "none";

      item_render(data);
    }).then(()=>{
			$("#brandnew_checkbox").on("change", function() {
				if ($(this).is(":checked")) filterOut_status["Brand New"] = false;
				else filterOut_status["Brand New"] = true;
				item_render(cache);
			});
		
			$("#likenew_checkbox").on("change", function() {
				if ($(this).is(":checked")) filterOut_status["Like New"] = false;
				else filterOut_status["Like New"] = true;
				item_render(cache);
			});
		
			$("#verygood_checkbox").on("change", function() {
				if ($(this).is(":checked")) filterOut_status["Very Good"] = false;
				else filterOut_status["Very Good"] = true;
				item_render(cache);
			});
		
			$("#good_checkbox").on("change", function() {
				if ($(this).is(":checked")) filterOut_status["Good"] = false;
				else filterOut_status["Good"] = true;
				item_render(cache);
			});
		
			$("#adequate_checkbox").on("change", function() {
				if ($(this).is(":checked")) filterOut_status["Adequate"] = false;
				else filterOut_status["Adequate"] = true;
				item_render(cache);
			});
		
			$("#defective_checkbox").on("change", function() {
				if ($(this).is(":checked")) filterOut_status["Defective"] = false;
				else filterOut_status["Defective"] = true;
				item_render(cache);
			});
		});
});

let user_render = userBlock => {
  document.getElementById("suggested_user_name").innerText =
    userBlock.result[0].display_name;
  document.getElementById("user_card").onclick = () => {
    window.location = "/user/profile/" + userBlock.result[0].id;
  };
  if (userBlock.borrowRate[0].borrow_rate !== null)
    document.getElementById(
      "suggest_user_borrow_rate"
    ).innerText = parseFloat(userBlock.borrowRate[0].borrow_rate).toFixed(2);
  else document.getElementById("suggest_user_borrow_rate").innerText = "None";
  if (userBlock.lendRate[0].lend_rate !== null)
    document.getElementById(
      "suggest_user_lend_rate"
    ).innerText = parseFloat(userBlock.lendRate[0].lend_rate).toFixed(2);
  else document.getElementById("suggest_user_lend_rate").innerText = "None";

  if (userBlock.result[0].gender == "Male")
    document.getElementById("suggested_user_gender").innerHTML =
      '<i class="fa fa-mars text-primary" aria-hidden="true"></i>';
  else if (userBlock.result[0].gender == "Female")
    document.getElementById("suggested_user_gender").innerHTML =
      '<i class="fa fa-mars text-danger" aria-hidden="true"></i>';
  else document.getElementById("suggested_user_gender").innerHTML = "";

  document.getElementById("suggested_user_photo").src = userBlock.display_photo;
  document.getElementById("user_card").onclick = function() {
    window.location = "/public_profiles/" + userBlock.result[0].id;
  };
  document.getElementById("user_section").style.display = "";
};

let item_render = itemList => {

	document.getElementById("itemISBN_section_content").innerHTML = "";
	document.getElementById("itemNameBrand_section_content").innerHTML = "";
	document.getElementById("itemISBN_section_content").innerHTML = "";
	document.getElementById("no_results_section").style.display = "none";

  let totalCount = 0;
  if (
    itemList.result_itemISBN !== null &&
    itemList.result_itemISBN !== undefined
  ) {
    document.getElementById("isbn_result_length").innerText =
      itemList.result_itemISBN.length;
    document.getElementById("isbn_keyword").innerText = itemList.search_keyword;
    for (let i = 0; i < itemList.result_itemISBN.length; i++) {
			if(filterOut_status[itemList.result_itemISBN[i].itemCondition])
			continue
			if(postcode_lock&&postcode_current!==null){
				if(itemList.result_itemISBN[i].postcode.toLowerCase().replace(" ","").indexOf(postcode_current)===-1){
					continue
				}
			}
      let history_count = 0;
      if (itemList.search_byISBN_requestsCount !== null) {
        let temp = itemList.search_byISBN_requestsCount.filter(
          x => x.itemID == itemList.result_itemISBN[i].itemID
        );
        if (temp.length > 0) history_count = temp[0]["count"];
      }
      let lenderRate = 0;
      if (itemList.search_byISBN_lenderRate !== null)
        lenderRate =
          itemList.search_byISBN_lenderRate[
            itemList.result_itemISBN[i].ownerID
          ];
      document.getElementById("itemISBN_section_content").innerHTML +=
        '<div class="col-lg-3 col-md-4 col-sm-6"><div class="card"><span class="item_detail_span" style="cursor:pointer" onclick="location.href = \'/items/' +
        itemList.result_itemISBN[i].itemID +
        '\'"><img class="card-img-top img-thumbnail" style="width:100%;height:250px; border-top-width: 0px; border-right-width: 0px;border-bottom-width: 0px;border-left-width: 0px;padding-top: 0px;padding-right: 0px;padding-bottom: 0px;padding-left: 0px;" src="' +
        itemList.result_itemISBN[i].itemPhoto +
        '" alt="Card image cap"/>' +
        condition_pill[itemList.result_itemISBN[i].itemCondition] +
        '<div class="card-body" style="padding-left: 10px;padding-bottom: 10px;padding-top: 10px;"><div style="line-height: 1.5em; height: 3em;overflow: hidden;"><strong class="card-title text-dark">' +
        itemList.result_itemISBN[i].name +
        '</strong></div><small class="text-dark"><u>Borrowed by ' +
        history_count +
        ' user(s)</u></small></div><hr style="margin-top:0;margin-bottom:0;" /></span><div class="card-body user_detail_span" onclick="location.href = \'/public_profiles/' +
        itemList.result_itemISBN[i].ownerID +
        '\';" style="cursor: pointer;padding-left: 10px;padding-bottom: 2px;padding-top: 5px;">' +
        '<span><img class="img-thumbnail" style="width:30px; height:30px; border-radius: 50%; padding-top:0; padding-bottom:0; padding-left:0; padding-right:0;" src="' +
        itemList.search_byISBN_lenderPhoto[
          itemList.result_itemISBN[i].ownerID
        ] +
        '"/>&nbsp; <label class="text-muted">' +
        itemList.result_itemISBN[i].ownerName +
        "</label>" +
        '<label class="pull-right text-warning" style="margin-top:1.5px;"><i class="fa fa-star"></i> ' +
        parseFloat(lenderRate).toFixed(1) +
        "</label></span></div></div></div>";
      totalCount++;
    }
    totalCount++;
    document.getElementById("itemISBN_section").style.display = "";
  }
  if (
    itemList.result_itemNameBrand.length !== 0 &&
    itemList.result_itemNameBrand !== null &&
    itemList.result_itemNameBrand !== undefined
  ) {
    document.getElementById("namebrand_result_count").innerText =
      itemList.result_itemNameBrand.length;
    document.getElementById("namebrand_keyword").innerText =
      itemList.search_keyword;

    for (let i = 0; i < itemList.result_itemNameBrand.length; i++) {
			if(filterOut_status[itemList.result_itemNameBrand[i].itemCondition])
				continue
				if(postcode_lock&&postcode_current!==null){
					if(itemList.result_itemNameBrand[i].postcode.toLowerCase().replace(" ","").indexOf(postcode_current)===-1){
						continue
					}
				}
      let history_count = 0;
      if (itemList.search_byNameBrand_requestsCount !== null) {
        let temp = itemList.search_byNameBrand_requestsCount.filter(
          x => x.itemID == itemList.result_itemNameBrand[i].itemID
        );
        if (temp.length > 0) history_count = temp[0]["count"];
      }
      let lenderRate = 0;
      if (itemList.search_byItemNameAndBrand_lenderRate !== null)
        lenderRate =
          itemList.search_byItemNameAndBrand_lenderRate[
            itemList.result_itemNameBrand[i].ownerID
					];
			console.log(lenderRate.toString())
      document.getElementById("itemNameBrand_section_content").innerHTML +=
        '<div class="col-lg-3 col-md-4 col-sm-6"><div class="card"><span class="item_detail_span" style="cursor:pointer" onclick="location.href = \'/items/' +
        itemList.result_itemNameBrand[i].itemID +
        '\'"><img class="card-img-top img-thumbnail" style="width:100%;height:250px; border-top-width: 0px; border-right-width: 0px;border-bottom-width: 0px;border-left-width: 0px;padding-top: 0px;padding-right: 0px;padding-bottom: 0px;padding-left: 0px;" src="' +
        itemList.result_itemNameBrand[i].itemPhoto +
        '" alt="Card image cap"/>' +
        condition_pill[itemList.result_itemNameBrand[i].itemCondition] +
        '<div class="card-body" style="padding-left: 10px;padding-bottom: 10px;padding-top: 10px;"><div style="line-height: 1.5em; height: 3em;overflow: hidden;"><strong class="card-title text-dark">' +
        itemList.result_itemNameBrand[i].name +
        '</strong></div><small class="text-dark"><u>Borrowed by ' +
        history_count +
        ' user(s)</u></small></div><hr style="margin-top:0;margin-bottom:0;" /></span><div class="card-body user_detail_span" onclick="location.href = \'/public_profiles/' +
        itemList.result_itemNameBrand[i].ownerID +
        '\';" style="cursor: pointer;padding-left: 10px;padding-bottom: 2px;padding-top: 5px;">' +
        '<span><img class="img-thumbnail" style="width:30px; height:30px; border-radius: 50%; padding-top:0; padding-bottom:0; padding-left:0; padding-right:0;" src="' +
        itemList.search_byItemNameAndBrand_lenderPhoto[
          itemList.result_itemNameBrand[i].ownerID
        ] +
        '"/>&nbsp; <label class="text-muted">' +
        itemList.result_itemNameBrand[i].ownerName +
        "</label>" +
        '<label class="pull-right text-warning" style="margin-top:1.5px;"><i class="fa fa-star"></i> ' +
        parseFloat(lenderRate).toFixed(1) +
        "</label></span></div></div></div>";
      totalCount++;
    }
    document.getElementById("itemNameBrand_section").style.display = "";
  }
  if (totalCount === 0) {
    if (
      itemList.result_correctedKeyword !== null &&
      itemList.result_correctedKeyword !== undefined &&
      itemList.corrected_keyword !== "" &&
      itemList.corrected_keyword !== null
    ) {
      document.getElementById("original_keyword").innerText =
        itemList.search_keyword;
      document.getElementById("corrected_keyword_results_count").innerText =
        itemList.result_correctedKeyword.length;
      document.getElementById("corrected_keyword").innerText =
        itemList.corrected_keyword;
      for (let i = 0; i < itemList.result_correctedKeyword.length; i++) {
				if(filterOut_status[itemList.result_correctedKeyword[i].itemCondition])
				continue
				if(postcode_lock&&postcode_current!==null){
					if(itemList.result_correctedKeyword[i].postcode.toLowerCase().replace(" ","").indexOf(postcode_current)===-1){
						continue
					}
				}
        let history_count = 0;
        if (itemList.search_byCorrection_requestsCount !== null) {
          let temp = itemList.search_byCorrection_requestsCount.filter(
            x => x.itemID == itemList.result_correctedKeyword[i].itemID
          );
          if (temp.length > 0) history_count = temp[0]["count"];
        }
        let lenderRate = 0;
        if (itemList.search_byCorrection_lenderRate !== null)
          lenderRate =
            itemList.search_byCorrection_lenderRate[
              itemList.result_correctedKeyword[i].ownerID
            ];
        document.getElementById("corrected_results_section_content").innerHTML +=
          '<div class="col-lg-3 col-md-4 col-sm-6"><div class="card"><span class="item_detail_span" style="cursor:pointer" onclick="location.href = \'/items/' +
          itemList.result_correctedKeyword[i].itemID +
          '\'"><img class="card-img-top img-thumbnail" style="width:100%;height:250px; border-top-width: 0px; border-right-width: 0px;border-bottom-width: 0px;border-left-width: 0px;padding-top: 0px;padding-right: 0px;padding-bottom: 0px;padding-left: 0px;" src="' +
          itemList.result_correctedKeyword[i].itemPhoto +
          '" alt="Card image cap"/>' +
          condition_pill[itemList.result_correctedKeyword[i].itemCondition] +
          '<div class="card-body" style="padding-left: 10px;padding-bottom: 10px;padding-top: 10px;"><div style="line-height: 1.5em; height: 3em;overflow: hidden;"><strong class="card-title text-dark">' +
          itemList.result_correctedKeyword[i].name +
          '</strong></div><small class="text-dark"><u>Borrowed by ' +
          history_count +
          ' user(s)</u></small></div><hr style="margin-top:0;margin-bottom:0;" /></span><div class="card-body user_detail_span" onclick="location.href = \'/public_profiles/' +
          itemList.result_correctedKeyword[i].ownerID +
          '\';" style="cursor: pointer;padding-left: 10px;padding-bottom: 2px;padding-top: 5px;">' +
          '<span><img class="img-thumbnail" style="width:30px; height:30px; border-radius: 50%; padding-top:0; padding-bottom:0; padding-left:0; padding-right:0;" src="' +
          itemList.search_byCorrection_lenderPhoto[
            itemList.result_correctedKeyword[i].ownerID
          ] +
          '"/>&nbsp; <label class="text-muted">' +
          itemList.result_correctedKeyword[i].ownerName +
          "</label>" +
          '<label class="pull-right text-warning" style="margin-top:1.5px;"><i class="fa fa-star"></i> ' +
          parseFloat(lenderRate).toFixed(1) +
          "</label></span></div></div></div>";
        totalCount++;
      }
      document.getElementById("corrected_results_section").style.display = "";
    } else {
      document.getElementById("keyword_no_results").innerText =
        itemList.search_keyword;
      document.getElementById("no_results_section").style.display = "";
    }
  }
};

let postcode_filter = ptr =>{
	if(ptr.value.length===0){
		postcode_lock = false;
		postcode_current = null;
		item_render(cache);
	}

	if(document.getElementById("current_country").innerText==="Canada"){
		if(ptr.value.length>=3&&ptr.value.length<6){
			postcode_lock = true;
			postcode_current = ptr.value.slice(0,3).toLowerCase();
			item_render(cache);
		}else if(ptr.value.length===6){
			postcode_lock = true;
			postcode_current = ptr.value.toLowerCase();
			item_render(cache);
		}else{
			postcode_lock = false;
			postcode_current = null;
			item_render(cache);
			return; 
		}
	}
	else{
		postcode_lock = true;
		postcode_current = ptr.value.toLowerCase();
		item_render(cache);
	}
	
	
}
