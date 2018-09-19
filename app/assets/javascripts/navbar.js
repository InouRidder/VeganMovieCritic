document.addEventListener('turbolinks:load', function() {
  var id = $('.selector').attr('id');
  $('#'+id).addClass('button-active');
});
