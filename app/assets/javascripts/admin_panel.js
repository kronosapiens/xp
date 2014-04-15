// $(document).ready(function(){
//   $("form#admin_email").hide();
//   $('#hide_admin_email').hide();

//   $('#show_admin_email').on("click", function(){
//     $('#show_admin_email').hide();
//     $("form#admin_email").slideDown(); 
//     $('#hide_admin_email').show();    
//   });

//   $('#hide_admin_email').on("click", function(e){
//     e.preventDefault();
//     $("form#admin_email").slideUp(function(){
//       $('#hide_admin_email').hide();
//       $('#show_admin_email').show();    
//     });
    
//   });

// });

function ajaxAdminEmail(){
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
};

function ajaxAdminPanel(){
  $('#admin-panel').hide();
  $('#hide-admin-panel').hide();

  $('#show-admin-panel').on("click", function(){
    $('#show-admin-panel').hide();
    $('#hide-admin-panel').show();
    $("#admin-panel").slideDown(); 
    $('#admin-panel').show();    
  });

  $('#hide-admin-panel').on("click", function(e){
    e.preventDefault();
    $("#admin-panel").slideUp(function(){
      $('#admin-panel').hide();
    });
    $('#hide-admin-panel').hide();
    $('#show-admin-panel').show();

  });
};

$(document).ready(function(){
  ajaxAdminEmail();
  ajaxAdminPanel();
});