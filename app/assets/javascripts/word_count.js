$(document).ready(function(e) {

  $('.btn-save').on('click', function(e) {

    var title_words = $('#review_title').val().trim().replace(/\s+/gi, ' ')

    if (( title_words.length > 20 ) || ((title_words.length - 1) < 1 )) {
      $('#review_title-error').empty().append('Please supply a title!');
      e.preventDefault();
      $("html, body").animate({ scrollTop: 0 }, 600);

    }

    var content_words = $('.size-it').val().trim().replace(/\s+/gi, ' ').split(' ')

    if ((content_words.length > 111)  || (content_words.length < 50 )) {
      e.preventDefault();
      $('.word-counter-error').empty().append('Please note that the length of the review must be between 50 and 110 words');
      $('.current-word-count').empty().append('Current amount words: ' + content_words.length + ' of 110');
      $("html, body").animate({ scrollTop: 190 }, 600);
    }

    if (content_words.length < 110 && content_words.length > 50){
      $('.word-counter-error').empty()
    }
    if (title_words.length < 20 && (title_words.length -1) >= 1 ){
      $('#review_title-error').empty()
    }
  });
});


  // function replaceAll(array) {
  //   var count = 0
  //   for (var i in array ) {
  //     if (i != '&nbsp;') {
  //       count += 1
  //     };
  //   };
  //   console.log(count);
  //   return count
  // };

