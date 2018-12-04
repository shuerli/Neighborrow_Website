function btnRequest(){

    var sdate = moment(document.getElementById('date-input').value.substring(0,10) , 'MM/DD/YYYY');
    sdate = moment(sdate).format('YYYY-MM-DD') + " 00:00:00"
    var edate = moment(document.getElementById('date-input').value.substring(13,23) , 'MM/DD/YYYY');
    edate = moment(edate).format('YYYY-MM-DD') + " 00:00:00"
    
    curLoc = window.location.href.split("/")
    itemId = curLoc[curLoc.length - 1];
    
    $.ajax({
           url: "/request",
           method: "POST",
           data: {
           authenticity_token: window._token,
               time_start: sdate,
               time_end: edate,
               item_id: itemId,
           }
           
           }).done(function(data) {
                   }).fail(function(data) {
                           alert( "request sent failed");
                           });

}
