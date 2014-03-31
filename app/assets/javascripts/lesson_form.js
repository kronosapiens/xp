$(document).ready(function(){ 


  $('input#student-role').on("change", function(){
    console.log("clicked");
    $('div#select-locations').hide();
    $('div#select-times').hide();
  });

  $('input#teacher-role').on("change", function(){
    // alert('ahahah');
    $('div#select-locations').show(); // dispaly block isn't right 
    $('div#select-times').show();
  });
});