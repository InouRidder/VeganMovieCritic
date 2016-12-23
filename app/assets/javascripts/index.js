baseUrl = 'http://localhost:3000/'

$(document).ready(function(){
  $(".super-btn").click(function(){
    event.preventDefault();
    id = $(this).attr('href');
    // $('.content-review-index').empty();
    $.ajax({
      type: 'GET',
      url: baseUrl + id,
      success: function(data) {
        $.post("getstuff.php", function(data){
        var mainDiv = $("#mainDiv", data); // finds <div id='mainDiv'>...</div>
        }, "html");
        $('.content-review-index').html("");
        $('.content-review-index').append(data);
        $('.card').removeClass('hidden');
      },
      error: function(html){
        console.log(html);
      }
    })
  });
});

window.onload = function(){
  var items = $('.card');
  $('.movie-info').append("I FOUND YOU");
  var currentItem = items.filter('.active');
  $(".next-button").on('click', function() {
    console.log("hello world");
    var nextItem = currentItem.next();
    currentItem.removeClass('active');
    if ( nextItem.length ) {
      currentItem = nextItem.addClass('active');
    } else {
        // If you want it to loop around
        currentItem = items.first().addClass('active');
      };
    });
};

