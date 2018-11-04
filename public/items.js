$('.img-wrap .close').on('click', function() {
  var id = $(this).closest('.img-wrap').find('img').data('id');
  alert('remove picture: ' + id);
});

var myCalendar;
function doOnLoad() {
  myCalendar = new dhtmlXCalendarObject(["date_from","date_to"]);
  myCalendar.setDate("2018-12-01");
  myCalendar.hideTime();
  
  // init values
  var t = new Date();
  byId("date_from").value = "2018-12-01";
  byId("date_to").value = "2018-12-01";
}

function setSens(id, k) {
  // update range
  if (k == "min") {
    myCalendar.setSensitiveRange(byId(id).value, null);
  } else {
    myCalendar.setSensitiveRange(null, byId(id).value);
  }
}
function byId(id) {
  return document.getElementById(id);
}



$(document).ready(function(){
  doOnLoad();
})

