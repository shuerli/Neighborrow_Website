
$(document).ready(function(){
  // Prepare the first dropdown menu for department selection with preload value
  $.ajax({
    type: "get",
    url: "/category/departments",
    success: function (data) {
        allDepartments = data.result;
        var departmentList = document.getElementById('department-input');
        for(var i = 0; i < allDepartments.length; i++){
            var opt = document.createElement("option");
            opt.setAttribute("value", allDepartments[i].department);
            opt.innerText = '' +allDepartments[i].department;
            departmentList.appendChild(opt);
        }
        departmentList.value = 'Miscellaneous';
        var opt = document.createElement("option");
        opt.setAttribute("value", 'Miscellaneous');
        opt.innerText = 'Miscellaneous';
        document.getElementById('category-input').appendChild(opt);
    }
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



function btnSubmit(){
 
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
                        $.ajax({
                        url: "/user_item",
                        method: "POST",
                        data: { 
                                authenticity_token: window._token,
                                category_id: category_id,
                                condition: item_condition,
                                time_start: sdate,
                                time_end: edate,
                                photo_url: url.substr(url.indexOf('/uploads')),
                                name: document.getElementById('item-name-input').value,
                                description: document.getElementById('description-input').value,
                                brand: document.getElementById('brand-input').value,
                                address: addressInfo.id,
                                rate_level: rate_level,
                                deposit: document.getElementById('deposit-input').value,
                            }
                        }).done(function(data){
                            window.location = "https://neighborrow.herokuaoo.com/user_item";
                        }).fail(function(data){
                            alert( "Item adding failed");
                        });
            });
        
        });
        
    });

};

function btnExit(){
  var result = confirm("Leaving this page will lose unsaved progress.\nAre you sure to leave this page?");
  if (result) {
      window.location = "https://neighborrow.herokuaoo.com/user_item";
  }
};
