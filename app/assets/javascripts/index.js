// CHANGE WHEN PUSHING TO HEROKU!

baseUrl = 'http://localhost:3000/'
// baseUrl = 'https://veganmoviecritic.herokuapp.com/'

$(document).ready(function(){
  $(".click-btn").click(function(){
    event.preventDefault();
    id = $(this).attr('href');
    $('.content-review-index').empty();
    $.ajax({
      type: 'GET',
      url: baseUrl + id + '/partial',
      success: function(data) {
        $('.content-review-index').append(data);
      },
      error: function(html){
        console.log(html);
      }
    })
  });
});
