$(document).ready(function(){
  $("a#show_all").on("click", function(e){
    e.preventDefault();
    $('div.jumbotron').show();
  });

  $("a#no_students").on("click", function(e){
    e.preventDefault();
    $('div.jumbotron').hide();
    $("div[data-students='0']").show();
  });

  $("a#no_teachers").on("click", function(e){
    e.preventDefault();
    $('div.jumbotron').hide();
    $("div[data-teachers='0']").show();
  });



  $("a#on_campus").on("click", function(e){
    e.preventDefault();
    $('div.jumbotron').hide();
    $("div[data-location='campus']").show();
  });

  $("a#remote").on("click", function(e){
    e.preventDefault();
    $('div.jumbotron').show();
    $("div[data-location='campus']").hide();
    $("div[data-location='virtual']").hide();
  });

  $("a#virtual").on("click", function(e){
    e.preventDefault();
    $('div.jumbotron').hide();
    $("div[data-location='virtual']").show();
  });



  $("ul#tags").on("click", "li a", function(e){
    e.preventDefault();
    var selected_tag = $(this).attr("data-tag");

    $('div.jumbotron').hide();

    $('div.jumbotron').each(function(){
      // var tags_array = $(this).attr("data-tags").split(", "); 
      if ($(this).attr("data-tags").toLowerCase().indexOf(selected_tag) >= 0){
        $(this).show();
      }

    });
  });

});