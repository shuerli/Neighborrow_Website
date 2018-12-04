function btnRequest(){

    var sdate = moment(document.getElementById('date-input').value.substring(0,10) , 'MM/DD/YYYY');
    //sdate = moment(sdate).format('YYYY-MM-DD') + " 00:00:00"
    var edate = moment(document.getElementById('date-input').value.substring(13,23) , 'MM/DD/YYYY');
    //edate = moment(edate).format('YYYY-MM-DD') + " 00:00:00"
    
    curLoc = window.location.href.split("/")
    itemId = curLoc[curLoc.length - 1];
    
    var st;
    var et;

    // $ajax({
    //     url: "/user_item/info",
    //     method: "GET",
    //     data: {
    //         id: itemId,
    //     }
    //     }).done(function(data) {
    //         itemInfo = data.result;
    //         //gets available time span
    //         startdate_string =  itemInfo.time_start;
    //         var startdate = moment(startdate_string.substring(0,10) ,'YYYY-MM-DD');
            
    //         enddate_string =  itemInfo.time_end;
    //         var enddate = moment(enddate_string.substring(0,10) ,'YYYY-MM-DD');
        

    //         //in request table find by item id and accepted, return a collection of time
    //         $.ajax({
    //             url: "/unavailable_time",
    //             method: "GET",
    //             data: {
    //                 item_id: itemId,
    //             }
    //             }).done(function(data) {

    //                 for(var i=0; i<data.length; i++){
    //                     start_string = data[i].time_start;
    //                     ustart = moment(start_string.substring(0,10) ,'YYYY-MM-DD');
    //                     enddate_string = data[i].time_end;
    //                     uend =  moment(end_string.substring(0,10) ,'YYYY-MM-DD');

                        
    //                 }
                    //creating request
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
    //                     });            
    // });
}
