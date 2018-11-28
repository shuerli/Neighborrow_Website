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





 function btnSave(){
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];


    var radio_button = document.forms[0];
    var i;
    var item_condition;
    for(i = 0; i < radio_button.length; i++){
        if(radio_button[i].checked){
            item_condition = radio_button[i].value;
        }
    }
    var sdate = moment(document.getElementById('date-input').value.substring(0,10) , 'MM/DD/YYYY');
    sdate = moment(sdate).format('YYYY-MM-DD') + " 00:00:00"
    var edate = moment(document.getElementById('date-input').value.substring(13,23) , 'MM/DD/YYYY');
    edate = moment(edate).format('YYYY-MM-DD') + " 00:00:00"

    $.ajax({
        url: "/user_item/edit",
        method: "PUT",
        data: { 
             authenticity_token: window._token,
             id: itemId,
             //category_id:
             condition: item_condition,
             time_start: sdate,
             time_end: edate,
             //photo_url: img_url,
             name: document.getElementById('item-name-input').value,
             description: document.getElementById('description-input').value,
             brand: document.getElementById('brand-input').value
           }
     }).done(function(data) {
        window.location = "http://localhost:3000/user_item/" + itemId;
       }).fail(function(data) {
         alert( "Item editing failed");
       });

 };



 function btnBack(){
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];

    var result = confirm("Leaving this page will lose unsaved progress.\nAre you sure to leave this page?");
    if (result) {
        window.location = "http://localhost:3000/user_item/" + itemId;
    }
 };