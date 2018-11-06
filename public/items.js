// For item removing button on top right of item image
$('.img-wrap .close').on('click', function() {
  var id = $(this).closest('.img-wrap').find('img').data('id');
  alert('remove picture: ' + id);
});

