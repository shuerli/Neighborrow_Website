$(document).ready(function () {    
    // Extract item id from current url
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];
    var category_id;
    // Pull data from database for this item
    $.get("/user_item/info/" + itemId, function (data) {
        itemInfo = data.result;

        
        document.getElementById('item-img').src = itemInfo.photo_url;
        document.getElementById('item-name-field').value = itemInfo.name;

        
        $.ajax({
            type: "get",
            url: "/categories/"+itemInfo.category_id,
            success: function (data) {
                categoryInfo = data.result;
                document.getElementById('department-field').value = categoryInfo.department;
                document.getElementById('category-field').value = categoryInfo.name;
            }
        });

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


        if(itemInfo.brand == null){
            document.getElementById('brand-field').value = ' - '
        }
        else{
            document.getElementById('brand-field').value = itemInfo.brand;
        }
        document.getElementById('condition-field').value = itemInfo.condition;
        document.getElementById('date-field').value =  moment(itemInfo.time_start).format('MM/DD/YYYY') + ' - ' + moment(itemInfo.time_end).format('MM/DD/YYYY');
        if(itemInfo.description == null){
            document.getElementById('description-field').value = ' - '
        }
        else{
            document.getElementById('description-field').value = itemInfo.description;
        }
        
        if(itemInfo.status == 'lent'){
            document.getElementById("btn-edit").style.visibility = "hidden";
        }

        
    });

    
});    



function btnEdit(){
    window.location = "http://localhost:3000/user_item/edit/" + itemId;
 };

 function btnExit(){
    window.location = "http://localhost:3000/user_item";
 };