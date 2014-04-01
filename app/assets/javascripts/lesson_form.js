$(document).ready(function(){ 


  $('input#student-role').on("change", function(){
    console.log("student clicked");
    $('div#options-for-teacher').hide();
    
  });

  $('input#teacher-role').on("change", function(){
    console.log("teacher clicked");
    $('div#options-for-teacher').show();
  });

  // console.log($("div#options-for-teacher").data("role"))
  // if( $("div#options-for-teacher").data("role") != "teacher"){
  //   $('div#options-for-teacher').hide();
  // };

});