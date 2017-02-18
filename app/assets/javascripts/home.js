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

  $(document).scroll(function() {  
    scroll_start = $(this).scrollTop();
    console.log("Scrolling! 3 --> " + scroll_start);
    if(scroll_start > 5) {
      $(".navbar-fixed-top").css('background-color', '#f0f0f0');
    }else {
      $('.navbar-fixed-top').css('background-color', 'transparent');
    }
  });

});