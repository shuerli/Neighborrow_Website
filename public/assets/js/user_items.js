 function btnItemDetail(itemId){
   window.location = "https://neighborrow.herokuaoo.com/user_item/" + itemId;
};

 function btnItemDelete(itemId){


  var result = confirm("Remove this item?");
  if (result) {
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
  
}


function btnItemAdd(){
  window.location = "https://neighborrow.herokuaoo.com/user_items/new";
};

//Receive data from controller when page loads
$(document).ready(function () {
  //Add image and name for lent items
  $.get("/user_item_all?type=lent", function (data) {
    if (data.status === 404) window.location("/404");
    else if (data.status === 403) window.location("/login");
    else {


          for (var i = 0; i < data.result.length; i++) {
            var cardField = document.createElement('div');
            cardField.className = "col-md-6"
            cardField.innerHTML = '<div class="card">\
                                    <div class="card-body">\
                                        <div class="row">\
                                          <div class="col-md-7">\
                                              <div class="row">\
                                                <div class="col-md-4 text-center">\
                                                  <img id="item-img-' + data.result[i].id + '" src="' + data.result[i].photo_url + '" alt="Item photo unavailable" class="img-thumbnail" style="width:80px; height:80px;">\
                                                </div>\
                                                <div class="col-md-8">\
                                                  <h4 id="item_name" style="font-size:18px; line-height: 1.5em; height: 1.5em; overflow: hidden;">' + data.result[i].name + ' </h4>\
                                                  <small>\
                                                  <a href="https://neighborrow.herokuaoo.com/user_item/' + data.result[i].id + '"> Item Detail</a>\
                                                  </small>\
                                                </div>\
                                              </div>\
                                          </div>\
                                          <div class="col-md-5 text-center" id="button_area">\
                                            <a id="btnMail">\
                                            <button class="btn btn-primary" style="width:65%;margin-bottom:15px;"> Contact Borrower </button>\
                                            </a>\
                                          </div>\
                                        </div>\
                                      </div>\
                                    </div>'
            document.getElementById("lent-items").appendChild(cardField);

            $.ajax({
              url: "/get_borrower",
              method: "GET",
              data: { 
                   itemId: data.result[i].id
                 }
           }).done(function(borrower) {
              document.getElementById('btnMail').setAttribute('href', "mailto:"+ borrower.borrower);
            });
         }
    }
  });
  
  //Add image and name for registered items, and add new item button
  $.get("/user_item_all?type=registered", function (data) {
    if (data.status === 404) window.location("/404");
    else if (data.status === 403) window.location("/login");
    else {
      for (var i = 0; i < data.result.length; i++) {
        var cardField = document.createElement('div');
        cardField.className = "col-md-6";
        cardField.innerHTML = '<div class="card">\
                                <div class="card-body">\
                                    <div class="row">\
                                      <div class="col-md-7">\
                                          <div class="row">\
                                            <div class="col-md-4 text-center">\
                                              <img id="item-img-' + data.result[i].id + '" src="' + data.result[i].photo_url + '" alt="Item photo unavailable" class="img-thumbnail" style="width:80px;height:80px;">\
                                            </div>\
                                            <div class="col-md-8">\
                                              <h4 id="item_name" style="font-size:18px; line-height: 1.5em; height: 1.5em; overflow: hidden;">' + data.result[i].name + ' </h4>\
                                              <small>\
                                              <a href="https://neighborrow.herokuaoo.com/user_item/' + data.result[i].id + '"> Item Detail</a>\
                                              </small>\
                                            </div>\
                                          </div>\
                                      </div>\
                                      <div class="col-md-5 text-center" id="button_area">\
                                        <button class="btn btn-danger" style="width:65%;margin-bottom:15px;" onclick="btnItemDelete(' + data.result[i].id +')" > Remove Item </button>\
                                      </div>\
                                    </div>\
                                  </div>\
                                </div>'

        document.getElementById("registered-items").appendChild(cardField);
      }


      var buttonAddImage = document.createElement('div');
        buttonAddImage.className = "col-md-6";
        buttonAddImage.setAttribute('onclick', 'btnItemAdd()');
        buttonAddImage.innerHTML = '<div class="card" id="btn-add-item" style="cursor:pointer; border-style:dashed; padding-top:10px; padding-bottom:10px;">\
                                    <div class="card-body">\
                                    <div class="row">\
                                    <div class="col-md-12 text-center">\
                                      <i class="fa fa-plus fa-5x"></i>\
                                      </div>\
                                    </div>\
                                    </div>\
                                    </div>'
      document.getElementById("registered-items").appendChild(buttonAddImage);
    }
  });

});
