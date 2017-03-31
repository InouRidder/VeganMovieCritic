// CHANGE WHEN PUSHING HEROKU!

// baseUrl = 'http://localhost:3000/'
baseUrl = 'http://www.veganmoviecritic.com'

$(window).load(function(){
  id = $(".click-btn:first-child").attr('href');
  $(".click-btn").removeClass('list-item-active');
  $(".click-btn:first-child").addClass('list-item-active');
  $.ajax({
    type: 'GET',
    crossDomain: true,
    url: baseUrl + id + '/partial',
    success: function(data) {
      $('.content-review-index').append(data);
      $('.container-background').css('background-size', 'cover');
      var background_url = $(".background-value").attr('data-hidden');
      $('.container-background').css('background-image', background_url);
    },
    error: function(html){
    }
  })
});

$(document).ready(function(){
  $(".click-btn").click(function(){
    event.preventDefault();
    $(".click-btn").removeClass('list-item-active');
    $(this).addClass('list-item-active');
    id = $(this).attr('href');
    $.ajax({
      type: 'GET',
      crossDomain: true,
      url: baseUrl + id + '/partial',
      success: function(data) {
        $('.content-review-index').html(data);
        $('.container-background').css('background-size', 'cover');
        var background_url = $(".background-value").attr('data-hidden');
        $('.container-background').css('background-image', background_url);
      }
    })
  });

  $('.review-rater').on('click', function(event){
    $('#review_rating').val($(this).attr('value'));
  });


  $('.content-review-index').on('click', '.review-rater', function(event){

    var element = $(this).prev('input');

    var gist = {
      "review_rating":
      {
        "user_id": element.attr('hidden-value'),
        "rating" : element.attr('value')
      }
    }
    var action = element.attr('action');

    if (!action){
      return false;
    }

    $.ajax({
      type: 'POST',
      url: action,
      data: gist,
      success: function(data){
        $('.card-rating').empty();
        $('.card-rating').append("Thanks for voting!")
        return false;
      },
      error: function(data){
        console.log('error');
        return false;
      }
    });
  });
});
