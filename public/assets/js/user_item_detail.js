$(document).ready(function () {    
    // Extract item id from current url
    curLoc = window.location.href.split("/");
    itemId = curLoc[curLoc.length - 1];
    
    // Pull data from database for this item
    $.get("/user_item/info/" + itemId, function (data) {
        alert("data loading successful")
        itemInfo = data.result;
        document.getElementById('item-img').src = itemInfo.photo_url;
        document.getElementById('item-name-input').value = itemInfo.name;
    });
});    