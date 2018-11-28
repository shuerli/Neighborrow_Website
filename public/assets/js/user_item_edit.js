$(document).ready(function () {    
    // Extract item id from current url
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];

    // Pull data from database for this item
    $.get("/user_item/info/" + itemId, function (data) {
        itemInfo = data.result;
        document.getElementById('item-img').src = itemInfo.photo_url;
        document.getElementById('item-name-input').value = itemInfo.name;
        if(itemInfo.brand == null){
            
        }
        else{
            document.getElementById('brand-input').value= itemInfo.brand;
        }
        //traverse radio button and modify check value
        //document.getElementById('condition-field').innerText = itemInfo.condition;
        var radio_button = document.forms[0];
        var i;
        var item_condition;
        for(i = 0; i < radio_button.length; i++){
            if(radio_button[i].value == itemInfo.condition){
                radio_button[i].checked = true;
            }
        }
        document.getElementById('date-input').value =  moment(itemInfo.time_start).format('MM/DD/YYYY') + ' - ' + moment(itemInfo.time_end).format('MM/DD/YYYY');
        if(itemInfo.description == null){

        }
        else{
            document.getElementById('description-input').value = itemInfo.description;
        }
        
    });
});    

function btnBack(){
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];
    window.location = "http://localhost:3000/user_item/" + itemId;
 };