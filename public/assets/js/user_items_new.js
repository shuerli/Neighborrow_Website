function btnSubmit(){
  
    var radio_button = document.forms[0];
    var i;
    var item_condition;
    for(i = 0; i < radio_button.length; i++){
        if(radio_button[i].checked){
            item_condition = radio_button[i].value;
        }
    }
    var sdate = moment(document.getElementById('date-input').value.substring(0,10) , 'MM/DD/YYYY');
    var edate = moment(document.getElementById('date-input').value.substring(13,23) , 'MM/DD/YYYY');
  
    // alert(document.getElementById('item-name-input').value);
    // alert(document.getElementById('description-input').value);
    // alert(document.getElementById('brand-input').value);

    $.ajax({
        url: "/user_item",
        method: "POST",
        data: { 
             authenticity_token: window._token,

             //need modify owner from rails controller
             owner: 'raymondfzy@gmail.com',
             status: 'registered',
             //category_id:
             condition: item_condition,
             time_start: sdate,
             time_end: edate,
             name: document.getElementById('item-name-input').value,
             
             //Need add photo url
             photo_url: '/assets/img/imgplaceholder.gif',
             description: document.getElementById('description-input').value,
             brand: document.getElementById('brand-input').value
           }
     }).done(function(data) {
        window.location = "http://localhost:3000/user_item";
       }).fail(function(data) {
         alert( "Item adding failed");
       });
 };