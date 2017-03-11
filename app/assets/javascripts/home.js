$(document).ready(function(){
  $('.sign-up-button').on('click', function(){
    $('.register-modal').modal("show");
  });

  $('.log-in-button').on('click', function(){
    $('.login-modal').modal("show");

  });
  $('.sign-up-modal-button').on('click', function(){
    $('.login-modal').modal("hide");
    $('.register-modal').modal("show");
  });
  $('.log-in-modal-button').on('click', function(){
    $('.login-modal').modal("show");
    $('.register-modal').modal("hide");
  });

  $(".share-spaces-button").click(function() {
    $('html, body').animate({
        scrollTop: $(".how-it-works").offset().top
    }, 1200);
  });

  $(".rent-spaces-button").click(function() {
    $('html, body').animate({
        scrollTop: $(".rent-spaces-section").offset().top
    }, 2000);
  });

  $(document).scroll(function() {  
    scroll_start = $(this).scrollTop();
    if(scroll_start > 5) {
      $(".navbar-fixed-top").css('background-color', '#f0f0f0');
      $(".navbar .container img").removeClass("normal-img");
      $(".navbar .container img").addClass("reduced-img");
      $(".navbar .container img").attr("src","reduced_dividup_logo.png");
    }else {
      $('.navbar-fixed-top').css('background-color', 'transparent');
      $(".navbar .container img").removeClass("reduced-img");
      $(".navbar .container img").addClass("normal-img");
      $(".navbar .container img").attr("src","dividup_logo.png");
    }
  });

  // if ($("#errors_sing_up").text() != ""){
  //   $('.register-modal').modal("show");
  // }

});