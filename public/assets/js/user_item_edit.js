$(document).ready(function () {    
    // Extract item id from current url
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];

    // Pull data from database for this item and prepare input fields
    $.get("/user_item/info/" + itemId, function (data) {
        itemInfo = data.result;

        document.getElementById('deposit-input').value = itemInfo.deposit;
        document.getElementById('rate-input').value = itemInfo.rate_level;

        document.getElementById('item-img').src = itemInfo.photo_url;
        document.getElementById('item-name-input').value = itemInfo.name;
        if(itemInfo.brand != null){
            document.getElementById('brand-input').value= itemInfo.brand;
        }
        //traverse radio button and modify check value
        var conditionList = document.getElementById('condition-input');
        for(var i = 0; i < conditionList.length; i++){
            if(conditionList[i].value == itemInfo.condition){
                conditionList[i].selected = true;
            }
        }
        document.getElementById('date-input').value =  moment(itemInfo.time_start).format('MM/DD/YYYY') + ' - ' + moment(itemInfo.time_end).format('MM/DD/YYYY');
        if(itemInfo.description != null){
            document.getElementById('description-input').value = itemInfo.description;
        }

        $.ajax({
            type: "get",
            url: "/address",
            data:
            {
                add: itemInfo.address,
            },
            success: function (data) {
                addressInfo = data.result;
                document.getElementById('street-input').value = addressInfo.address_line1;
                document.getElementById('city-input').value = addressInfo.city;
                document.getElementById('province-input').value = addressInfo.province;
                document.getElementById('country-input').value = addressInfo.country;
                document.getElementById('postalcode-input').value = addressInfo.postal_code;
            }
        });
        // Get category info from DB
        $.ajax({
            type: "get",
            url: "/categories/"+itemInfo.category_id,
            success: function (data) {
                categoryInfo = data.result;

                // Prepare the first dropdown menu for department selection with preload value
                $.ajax({
                    type: "get",
                    url: "/category/departments",
                    success: function (data) {
                        allDepartments = data.result;
                        var i;
                        for(i = 0; i < allDepartments.length; i++){
                            var opt = document.createElement("option");
                            opt.setAttribute("value", allDepartments[i].department);
                            if(allDepartments[i].department == categoryInfo.department){
                                opt.setAttribute("selected", "selected");
                            }
                            opt.innerText = '' +allDepartments[i].department;
                            document.getElementById('department-input').appendChild(opt);
                        }

                        $.ajax({
                            type: "get",
                            url: "/category/department/category_names",
                            data: {
                                department: categoryInfo.department
                            },
                            success: function (data) {

                                allCategories = data.result;
                                var i;
                                for(i = 0; i < allCategories.length; i++){
                                    var opt = document.createElement("option");
                                    opt.setAttribute("value", allCategories[i].name);
                                    if(allCategories[i].name == categoryInfo.name){
                                        opt.setAttribute("selected", "selected");
                                    }
                                    opt.innerText = ''+allCategories[i].name;
                                    document.getElementById('category-input').appendChild(opt);
                                }
                            }
                        });
                    }
                });
            }
        });
    });
});    


// Change options for the second dropdown menu when the first one is selected
$('#department-input').change(function () {
    var selectedDepartment = $(this).find("option:selected").text();

    $.ajax({
        type: "get",
        url: "/category/department/category_names",
        data: {
            department: selectedDepartment
        },
        success: function (data) {
            var category_menu = document.getElementById('category-input');
            while (category_menu.firstChild){
                category_menu.removeChild(category_menu.firstChild);
            }

            allCategories = data.result;
            var i;
            for(i = 0; i < allCategories.length; i++){
                var opt = document.createElement("option");
                opt.setAttribute("value", allCategories[i].name);
                opt.innerText = ''+allCategories[i].name;
                document.getElementById('category-input').appendChild(opt);
            }
        }
    });
});

 function btnSave(){
    

    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];


    
    var conditionList = document.getElementById('condition-input');
    var item_condition = conditionList.options[conditionList.selectedIndex].value;
    var rateList = document.getElementById('rate-input');
    var rate_level = rateList.options[rateList.selectedIndex].value;

    var sdate = moment(document.getElementById('date-input').value.substring(0,10) , 'MM/DD/YYYY');
    sdate = moment(sdate).format('YYYY-MM-DD') + " 00:00:00"
    var edate = moment(document.getElementById('date-input').value.substring(13,23) , 'MM/DD/YYYY');
    edate = moment(edate).format('YYYY-MM-DD') + " 00:00:00"
    $.ajax({
        url: "/category/id",
        method: "GET",
        data:{
            department: $('#department-input option:selected').val(),
            category: $('#category-input option:selected').val()
        }
      }).done(function(data){
        var category_id = data.result[0].id;
        $.ajax({
            url: '/media_contents',
            method: "GET",
        }).done(function(url){

            $.ajax({
                url: "/address_new",
                method: "POST",
                data:{
                    authenticity_token: window._token,
                    address_line1: $('#street-input').val(),
                    city: $('#city-input').val(),
                    province: $('#province-input').val(),
                    country: $('#country-input').val(),
                    postal_code: $('#postalcode-input').val(),
                }
          }).done(function(addressInfo){
              var img;
              if (!new_photo){
                  img = null;
              }
              else{
                  img = url.substr(url.indexOf('/uploads'));
              }
                            $.ajax({
                            url: "/user_item/edit",
                            method: "PUT",
                            data: { 
                                    authenticity_token: window._token,
                                    remove_photo: remove_photo,
                                    new_photo: new_photo,
                                    id: itemId,
                                    category_id: category_id,
                                    condition: item_condition,
                                    time_start: sdate,
                                    time_end: edate,
                                    photo_url: img,
                                    name: document.getElementById('item-name-input').value,
                                    description: document.getElementById('description-input').value,
                                    brand: document.getElementById('brand-input').value,
                                    address: addressInfo.id,
                                    rate_level: rate_level,
                                    deposit: document.getElementById('deposit-input').value,
                                }
                            }).done(function(data){
                                window.location = "https://neighborrow.herokuapp.com/user_item/" + itemId;
                            }).fail(function(data){
                                alert( "Please fill all the empty forms!");
                            });
        });
      });
    });
 };



 function btnBack(){
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];

    var result = confirm("Leaving this page will lose unsaved progress.\nAre you sure to leave this page?");
    if (result) {
        window.location = "https://neighborrow.herokuapp.com/user_item/" + itemId;
    }
 };

 function btnImageDelete(){
    var result = confirm("Remove image?");
    if (result) {
        $('#existing-img').remove();
        remove_photo = true;
        document.getElementById('media-dropzone').style.visibility = 'visible';
    }
 }

 $('#media-dropzone').on('click', function(){
    new_photo = true;
 });
 var remove_photo = false;
 var new_photo = false;
