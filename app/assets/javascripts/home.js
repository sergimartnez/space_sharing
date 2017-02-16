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
});