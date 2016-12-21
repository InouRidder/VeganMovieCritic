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
    console.log(this);
      $.ajax({
    type: 'GET',
    url: baseUrl + id,
      success: function(data) {
      $('content-review-index').append(data);
      console.log(data)
    },
    error: function(data){
      console.log(data)
    }
  })
  });
});




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
