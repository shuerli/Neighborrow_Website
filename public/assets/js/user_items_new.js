function btnSubmit(){
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
             name: document.getElementById('item-name-input').value,

             //Need add photo url
            // photo_url: '/assets/img/imgplaceholder.gif',
            
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