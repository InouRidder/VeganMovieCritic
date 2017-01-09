$(document).ready(function () {
    $('.navbar-wagon-button').click(function () {
      console.log("hello???");
        $(this).siblings().removeClass('navbar-wagon-button-active');
        $(this).addClass('navbar-wagon-button-active');
    });
});
