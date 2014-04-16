$(document).ready(function(){

  $('#calculate-btn').click(function () {
    var btn = $(this);
    btn.button('loading');
  });

});

function addBioToPage(bio_text){
  $("#bio-form").remove();
  $("#bio-text").html(bio_text);
};