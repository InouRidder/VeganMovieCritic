// $.urlParam = function(name, url) {
// if (!url) {
//  url = window.location.href;
//  console.log(url);
// };
// };

baseUrl = 'http://localhost:3000/'

$(document).ready(function(){
  $(".super-btn").click(function(){
  event.preventDefault();
    id = $(this).attr('href');
    $('.content-review-index').empty();
      $.ajax({
    type: 'GET',
    url: baseUrl + id,
      success: function(data) {
       $('.content-review-index').html("");
        $('.content-review-index').append(data);
    },
    error: function(html){
      console.log(html);
    }
  })
  });
});
        // console.log($('.review-content-container').val());


      // $('content-review-index').append(html);




  // $.ajax({
  //   type: 'GET',
  //   url: baseUrl + promo + '/comments',
  //   data: review,
  //     success: function(review) {
  //     review.forEach(function(value) {
  //     $('content-review-index').append('# HELLO WORLD #')});
  //     console.log(review)
  //   },
  //   error: function(review){
  //     console.log(review)
  //   }
  // })


    // $.ajax({
    //   type: 'GET',
    //   url: baseUrl + $("/10")

    //   success: function(data) {
    //   data.forEach(function(value) {
    //     console.log(data);
    //     $('.content-review-index').append('#HELLO WORLD#')});
    // });,
    //   error: function(data){
    //   console.log(data)


  // event.preventDefault();

  // $.ajax({
  //   type: 'POST',
  //   url: baseUrl + promo + '/comments',
  //   data: commentJson,
  //   success: function(data) {
  //    console.log("Post succeeded")
  //  },
  //  error: function(data) {
  //   console.log("Failure to post")
  // }
  // })
