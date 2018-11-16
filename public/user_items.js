 // For item removing button on top right of item image
function btnDelete(itemId){
  
  // $.ajax({
  //   method: "PUT",
  //   url: '/user_item/'+itemId,
  //   data: { 
  //         status: "disabled", 
  //         authenticity_token: window._token}
  // }).done(function( msg ) {
  //     alert( "Item removed: " + msg );
  //   });
    alert(itemId);
   };
function btnAddItem(){
    // $.ajax({
  //   method: "POST",
  //   url: '/user_item',
  //   data: { 
              //data read from user input form in html
  
  //         authenticity_token: window._token}
  // }).done(function( msg ) {
  //     alert( "Item added: " + msg );
  //   });
  alert('function responsive');
};

//Receive data from controller when page loads
$(document).ready(function () {
  //Add image and name for lent items
  $.get("/user_item?type=lent", function (data) {
    for (var i = 0; i < data.result.length; i++) {
      var divImage = document.createElement('div');
      divImage.className = "col-2"
      divImage.innerHTML = '<h2><img src="' + data.result[i].photo_url + '" alt="imgplaceholder.gif" class="img-fluid img-thumbnail"></h2>\
                            <p>' + data.result[i].name + '</p>';
      document.getElementById("lent-items").appendChild(divImage);
    }
  });
  
  //Add image and name for registered items, and add new item button
  $.get("/user_item?type=registered", function (data) {
    for (var i = 0; i < data.result.length; i++) {
      var divImage = document.createElement('div');
      divImage.className = "img-wrap col-2"
      divImage.innerHTML = '<span class="close" onclick="btnDelete(' + i +')" >&times;</span>\
                          <h2><img src="' + data.result[i].photo_url + '" alt="imgplaceholder.gif" class="img-fluid img-thumbnail" ></h2>\
                            <p>' + data.result[i].name + '</p>';
      document.getElementById("registered-items").appendChild(divImage);
    }
    //onclick = "test(' + id + ')"

    var buttonAddImage = document.createElement('button');
    buttonAddImage.setAttribute('onclick', 'btnAddItem()');

    buttonAddImage.className = "btn btn-secondary col-2";
    buttonAddImage.innerHTML = '<i class="fa fa-plus fa-5x"></i>'
    buttonAddImage.setAttribute("style", "margin:50px 50px 50px 50px;");
    document.getElementById("registered-items").appendChild(buttonAddImage);
  });

});