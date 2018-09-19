document.addEventListener('turbolinks:load', function() {
  $(".next-btn").click(function(){
    var element = $(".current-element").next(".next-method");
    $(".next-method").addClass("hidden").removeClass("current-element");
    element.removeClass('hidden').addClass("current-element");
    console.log(element);
    $('body, html').animate({
     scrollTop: 0},700);
  });

  $(".prev-btn").click(function(){
   var element = $(".current-element").prev(".next-method");
    $(".next-method").addClass("hidden").removeClass("current-element");
    element.removeClass('hidden').addClass('current-element');
    console.log(element);
    $('body, html').animate({
     scrollTop: 0},700);
  });
});

