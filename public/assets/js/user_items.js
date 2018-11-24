 function btnItemDetail(itemId){
   window.location = "http://localhost:3000/user_item/" + itemId;
};

 function btnItemDelete(itemId){
  $.ajax({
     url: "/user_item",
     method: "PUT",
     data: { 
          authenticity_token: window._token,
          id: itemId
        }
  }).done(function(data) {
      location.reload();
    }).fail(function(data) {
      alert( "Item remove failed");
    });
}


function btnItemAdd(){
  window.location = "http://localhost:3000/user_items/new";
};

//Receive data from controller when page loads
$(document).ready(function () {
  //Add image and name for lent items
  $.get("/user_item_all?type=lent", function (data) {
    if (data.status === 404) window.location("/404");
    else if (data.status === 403) window.location("/login");
    else {
      for (var i = 0; i < data.result.length; i++) {
        var divImage = document.createElement('div');
        divImage.className = "col-2"
        divImage.innerHTML = '<h2><img id="item-img-' + data.result[i].id + '" src="' + data.result[i].photo_url + '" alt="item image" class="img-fluid img-thumbnail" onclick="btnItemDetail('+ data.result[i].id +')"></h2>\
                              <p>' + data.result[i].name + '</p>';
        document.getElementById("lent-items").appendChild(divImage);
      }
    }
  });
  
  //Add image and name for registered items, and add new item button
  $.get("/user_item_all?type=registered", function (data) {
    if (data.status === 404) window.location("/404");
    else if (data.status === 403) window.location("/login");
    else {
      for (var i = 0; i < data.result.length; i++) {
        var divImage = document.createElement('div');
        divImage.className = "img-wrap col-2"
        divImage.innerHTML = '<span class="close" onclick="btnItemDelete(' + data.result[i].id +')" >&times;</span>\
                            <h2><img id="item-img-' + data.result[i].id + '" src="' + data.result[i].photo_url + '" alt="item image" class="img-fluid img-thumbnail" onclick="btnItemDetail('+ data.result[i].id +')"></h2>\
                              <p>' + data.result[i].name + '</p>';
        document.getElementById("registered-items").appendChild(divImage);
      }
      //onclick = "test(' + id + ')"

      var buttonAddImage = document.createElement('button');
      buttonAddImage.setAttribute('onclick', 'btnItemAdd()');

      buttonAddImage.className = "btn btn-secondary col-2";
      buttonAddImage.innerHTML = '<i class="fa fa-plus fa-5x"></i>'
      buttonAddImage.setAttribute("style", "margin:50px 50px 50px 50px;");
      document.getElementById("registered-items").appendChild(buttonAddImage);
    }
  });

});