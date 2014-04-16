$(document).ready(function(){

  $('#calculate-btn').click(function () {
    var btn = $(this);
    btn.button('loading');
  });

});

function addBioToPage(bio_text){
  $("#bio-form").html("");
  $("#bio-text").html(bio_text);
};

function addBioFormToPage(bio_form){
  $("#bio-form").html(bio_form);
};