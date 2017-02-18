// CHANGE WHEN PUSHING TO HEROKU!
// baseUrl = 'http://localhost:3000/'
baseUrl = 'http://www.veganmoviecritic.com'

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
    }
  })

});

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
      }
    })
  });

  $('.review-rater').on('click', function(event){
    // var star = $(this).attr('value');
    // console.log(star);
    $('#review_rating').val($(this).attr('value'));
  });


  $('.content-review-index').on('click', '.review-rater', function(event){
    var star = $(this).attr('value');
    var user = $(this).attr('hidden-value');
    $.ajax({
      type: 'POST',
      url: $(this).attr('action'),
      data: { "review_rating" : { "user_id" : user, "rating" : star } },
      succes: function(){
        console.log("reverse error, awesome coding");
      },
      error: function(){
      $('.card-rating').empty();
      $('.card-rating').append("Thanks for voting!")      }
    });
  });
});

// need to save this.attr('value') into a temporary variable - then pass it as :rating on submit.



