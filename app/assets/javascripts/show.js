$(document).ready(function(){

  $(".next-btn").click(function(){
    $(".next-method").next().removeClass("hidden");
    $(".next-method").prev().addClass("hidden");
  });

  $(".prev-btn").click(function(){
    $(".next-method").prev().removeClass("hidden");
    $(".next-method").next().addClass("hidden");
    $(".next-btn").removeClass("hidden");
  });
});
