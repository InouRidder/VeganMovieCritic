$(document).ready(function(){
  var id = $('.selector').attr('id');
  console.log(id);
  $('#'+id).addClass('button-active');
});
