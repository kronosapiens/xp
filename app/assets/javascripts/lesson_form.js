$(document).ready(function(){ 

// $("ul[data-group='Companies'] li[data-company='Microsoft']")
  $("div[data-status='teachers-only']").hide();
  // $('div#hide-from-students').hide();

  $('input#student-role').on("change", function(){
    console.log("student clicked");
    $('div#hide-from-students').hide();
    // $("div[data-status='teachers-only']").hide();
    
  });

  $('input#teacher-role').on("change", function(){
    console.log("teacher clicked");
    $('div#hide-from-students').show();
    // $("div[data-status='teachers-only']").show();
  });
});