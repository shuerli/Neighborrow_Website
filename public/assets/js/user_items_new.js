
var img_url;
var img_id;


 $(function() {
     alert("function is being invoked")
    var mediaDropzone = new Dropzone("#media-dropzone");
    Dropzone.options.mediaDropzone = false;
    mediaDropzone.options.acceptedFiles = ".jpeg,.jpg,.png,.gif";
    mediaDropzone.on("complete", function(files) {
      var _this = this;
      if (_this.getUploadingFiles().length === 0 && _this.getQueuedFiles().length === 0) {
        setTimeout(function(){
          var acceptedFiles = _this.getAcceptedFiles();
          var rejectedFiles = _this.getRejectedFiles();
  
          for(var index = 0; index < acceptedFiles.length; index++) {
            var file = acceptedFiles[index];
            var response = JSON.parse(file.xhr.response);

            img_url = response.file_name.url;
            img_id = response.id;
          }
  
          if(acceptedFiles.length != 0) {
            alertify.success('Uploaded ' + acceptedFiles.length + ' files successfully.');
          }
          if(rejectedFiles.length != 0) {
            alertify.error('Error uploading ' + rejectedFiles.length + ' files. Only image files are accepted.');
          }
  
          _this.removeAllFiles();
  
        }, 2000);
      }
    });
  });
  

  function btnSubmit(){
    
    //alert("image url respond from server is " + img_url);


    var radio_button = document.forms[1];
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
        url: "/user_item",
        method: "POST",
        data: { 
             authenticity_token: window._token,

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
        window.location = "http://localhost:3000/user_item";
       }).fail(function(data) {
         alert( "Item adding failed");
       });


   // alert("everything after sending post request")
 };