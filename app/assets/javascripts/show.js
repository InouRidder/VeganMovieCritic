$(document).ready(function(){

  $(".next-btn").click(function(){
    $(".next-method").next().removeClass("hidden");
    $(".next-method").prev().addClass("hidden");
    $('body, html').animate({
     scrollTop: 0},700);
  });

  $(".prev-btn").click(function(){
    $(".next-method").prev().removeClass("hidden");
    $(".next-method").next().addClass("hidden");
    $(".next-btn").removeClass("hidden");
    $(".col-xs-2 pull-right").removeClass("hidden");
    $('body, html').animate({
     scrollTop: 0},700);
  });
});
