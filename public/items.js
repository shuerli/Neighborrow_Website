// For item removing button on top right of item image
$('.img-wrap .close').on('click', function() {
//  var id = $(this).closest('.img-wrap').find('img').data('id');
//  alert('remove picture: ' + id);
});


//Receive data from controller when page loads
$(document).ready(function() {
  //Add image and name for lent items
  $.get("/user_item?type=lent",function(data){
      for (var i=0;i<data.result.length;i++){
        var divImage = document.createElement('div');
        divImage.className = "col-2"
        divImage.innerHTML = '<h2><img src="' + data.result[i].photo_url + '" alt="imgplaceholder.gif" class="img-fluid img-thumbnail"></h2>\
                            <p>' + data.result[i].name + '</p>';
        document.getElementById("lent-items").appendChild(divImage);
      }
  });
  //Add image and name for registered items, and add new item button
  $.get("/user_item?type=registered",function(data){
    for (var i=0;i<data.result.length;i++){
      var divImage = document.createElement('div');
      divImage.className = "img-wrap";
      divImage.className = "col-2"
      divImage.innerHTML = '<span class="close">&times;</span>\
                          <h2><img src="' + data.result[i].photo_url + '" alt="imgplaceholder.gif" class="img-fluid img-thumbnail" ></h2>\
                            <p>' + data.result[i].name + '</p>';
      document.getElementById("registered-items").appendChild(divImage);
    }
    var buttonAddImage = document.createElement('button');
      buttonAddImage.className = "btn btn-secondary";
      buttonAddImage.className = "col-2"
      buttonAddImage.innerHTML = '<i class="fa fa-plus fa-5x"></i>'
      buttonAddImage.setAttribute("style","margin:50px 50px 50px 50px;");
      document.getElementById("registered-items").appendChild(buttonAddImage);
  });
});