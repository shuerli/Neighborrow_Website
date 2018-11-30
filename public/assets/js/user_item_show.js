$(document).ready(function () {    
    // Extract item id from current url
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];
    var category_id;
    // Pull data from database for this item
    $.get("/user_item/info/" + itemId, function (data) {
        itemInfo = data.result;

        alert(itemInfo.photo_url)

        
        document.getElementById('item-img').src = itemInfo.photo_url;
        document.getElementById('item-name-field').innerText = itemInfo.name;

        
        $.ajax({
            type: "get",
            url: "/categories/"+itemInfo.category_id,
            success: function (data) {
                categoryInfo = data.result;
                document.getElementById('department-field').innerText = categoryInfo.department;
                document.getElementById('category-field').innerText = categoryInfo.name;
            }
        });

        if(itemInfo.brand == null){
            document.getElementById('brand-field').innerText = ' - '
        }
        else{
            document.getElementById('brand-field').innerText = itemInfo.brand;
        }
        document.getElementById('condition-field').innerText = itemInfo.condition;
        document.getElementById('date-field').innerText =  moment(itemInfo.time_start).format('MM/DD/YYYY') + ' - ' + moment(itemInfo.time_end).format('MM/DD/YYYY');
        if(itemInfo.description == null){
            document.getElementById('description-field').innerText = ' - '
        }
        else{
            document.getElementById('description-field').innerText = itemInfo.description;
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