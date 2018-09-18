
function starRater() {
  var form = $('#new_review_rating');
  document.querySelectorAll('.star-rating').forEach(function(starRating) {
    starRating.addEventListener('click', function(e) {
      form.trigger('submit.rails')
    })
  })
}

document.addEventListener('DOMContentLoaded', starRater)
