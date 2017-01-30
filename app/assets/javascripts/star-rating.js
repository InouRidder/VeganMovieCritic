$(document).ready(function(){
$('.review-rater').click(function(){
  var value = $('.star-rating').val();
  console.log("####################### HALLO #############");
        $.ajax({
      type: 'POST',
      url: review_ratings_path
      });
    })
});

