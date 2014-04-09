$(document).ready(function(){
  $("form#admin_email").hide();
  $('#hide_admin_email').hide();

  $('#show_admin_email').on("click", function(){
    $('#show_admin_email').hide();
    $("form#admin_email").slideDown(); 
    $('#hide_admin_email').show();    
  });

  $('#hide_admin_email').on("click", function(e){
    e.preventDefault();
    $("form#admin_email").slideUp(function(){
      $('#hide_admin_email').hide();
      $('#show_admin_email').show();    
    });
    
  });

});