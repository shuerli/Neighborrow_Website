function btnRequest(){

    var sdate = moment(document.getElementById('date-input').value.substring(0,10) , 'MM/DD/YYYY');
    sdate = moment(sdate).format('YYYY-MM-DD') + " 00:00:00"
    var edate = moment(document.getElementById('date-input').value.substring(13,23) , 'MM/DD/YYYY');
    edate = moment(edate).format('YYYY-MM-DD') + " 00:00:00"
    
    
    
    
    $.ajax({
           url: "/request",
           method: "PUT",
           data: {
           authenticity_token: window._token,
           
           time_start: sdate,
           time_end: edate,
           address: document.getElementById()
           
           description: document.getElementById('description-input').value,
           brand: document.getElementById('brand-input').value
           }
           
           }).done(function(data) {
                   window.location = "http://localhost:3000/user_item";
                   }).fail(function(data) {
                           alert( "Item adding failed");
                           });
};
