// For item removing button on top right of item image
$('.img-wrap .close').on('click', function() {
//  var id = $(this).closest('.img-wrap').find('img').data('id');
//  alert('remove picture: ' + id);
});



//Receive data from controller when page loads
$(document).ready(function() {
  //Add image and name for lent items
  $.get("/item?type=lent",function(data){
      for (var i=0;i<data.result.length;i++){
        var divImage = document.createElement('div');
        divImage.innerHTML = '<h2><img src="imgplaceholder.gif" alt="my lent item" width="150" height="150" ></h2>\
                            <p>' + data.result[i].name + '</p>';
        document.getElementById("lent-items").appendChild(divImage);
      }
  });
  //Add image and name for registered items, and add new item button
  $.get("/item?type=registered",function(data){
    for (var i=0;i<data.result.length;i++){
      var divImage = document.createElement('div');
      divImage.className = "img-wrap";
      divImage.innerHTML = '<span class="close">&times;</span>\
                          <h2><img src="' + data.result[i].photo_url + '" alt="my registered item" width="150" height="150"></h2>\
                            <p>' + data.result[i].name + '</p>';
      document.getElementById("registered-items").appendChild(divImage);
    }
    var buttonAddImage = document.createElement('button');
      buttonAddImage.className = "btn btn-secondary";
      buttonAddImage.innerHTML = '<i class="fa fa-plus fa-5x"></i>'
      document.getElementById("registered-items").appendChild(buttonAddImage);
  });
});