$(document).ready(function(){
  // Change image every 10 seconds
  // function set_body_height() { // set body height = window height
  //   $('.top-subcontainer').height($(window).height());
  // }
  
  // $(window).bind('resize', set_body_height);
  // set_body_height();


  setInterval(function() {
    $('ul img').fadeOut(400,function(){
      if ($(this).attr('src') == "landing-1.jpg") {
        $(this).attr('src','landing-2.jpg').fadeIn(400);
      } else{
        $(this).attr('src','landing-1.jpg').fadeIn(400);
      }
    });
    // var inactive = $('ul img.inactive').removeClass('inactive');
    // var active = $('ul img.active').removeClass('active');
    // inactive.addClass('active');
    // active.addClass('inactive');
  }, 10000);

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

  $(".share-spaces-button").click(function(event) {
    event.preventDefault()
    $('html, body').animate({
        scrollTop: $(".how-it-works").offset().top
    }, 1500);
  });

  $(".rent-spaces-button").click(function(event) {
    event.preventDefault()
    $('html, body').animate({
        scrollTop: $(".rent-spaces-section").offset().top
    }, 1500);
  });

  $(document).scroll(function() {  
    scroll_start = $(this).scrollTop();
    if(scroll_start > 5) {
      $(".navbar-fixed-top").removeClass("nav-top");
      $(".navbar-fixed-top").addClass("nav-moving");
      $(".navbar .container img").removeClass("normal-img");
      $(".navbar .container img").addClass("reduced-img");
      $(".navbar .container img").attr("src","reduced_dividup_logo.png");
    }else {
      $(".navbar-fixed-top").addClass("nav-top");
      $(".navbar-fixed-top").removeClass("nav-moving");
      $(".navbar .container img").removeClass("reduced-img");
      $(".navbar .container img").addClass("normal-img");
      $(".navbar .container img").attr("src","dividup_logo.png");
    }
  });
  new google.maps.places.Autocomplete(
  (document.getElementById('autocomplete')), {
    types: ['geocode']
  });
  // TO-DO manage the sing-in sign-up errors

  // if ($("#errors_sing_up").text() != ""){
  //   $('.register-modal').modal("show");
  // }

});