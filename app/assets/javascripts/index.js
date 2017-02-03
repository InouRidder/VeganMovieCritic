// CHANGE WHEN PUSHING TO HEROKU!
baseUrl = 'http://localhost:3000/'
// baseUrl = 'https://veganmoviecritic.herokuapp.com'

$(document).ready(function(){
  $(".click-btn").click(function(){
    event.preventDefault();
    $(".click-btn").removeClass('list-item-active');
    $(this).addClass('list-item-active');
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
  $(window).load(function(){
    id = $(".click-btn:first-child").attr('href');
    $(".click-btn").removeClass('list-item-active');
    $(".click-btn:first-child").addClass('list-item-active');
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

  $('.content-review-index').on('click', '.review-rater', function(event){
    var star = $(this).attr('value');
    var user = $(this).attr('hidden-value');
    $.ajax({
      type: 'POST',
      url: $(this).attr('action'),
      data: { "review_rating" : { "user_id" : user, "rating" : star } },
      succes: function(data) {
        $('.card-rating').append("Thanks for voting!");
      }
    });
  });
});



