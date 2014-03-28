$(document).ready(function () {

// Code for filtering by teacher/student status
$("a#no_teachers").on("click", function(e){
  e.preventDefault();
  $('li').hide();
  $("li[data-teachers='0']").show();
});

$("a#no_students").on("click", function(e){
  e.preventDefault();
  $('li').hide();
  $("li[data-students='0']").show();
});

$("a#show_all").on("click", function(e){
  e.preventDefault();
  $('li').show();
});

  // Configure Chosen 

  var config = {
    '.chosen-select'           : {},
    '.chosen-select-deselect'  : {allow_single_deselect:true},
    '.chosen-select-no-single' : {disable_search_threshold:10},
    '.chosen-select-no-results': {no_results_text:'No tags found'},
    '.chosen-select-width'     : {width:"95%"}
  }
  for (var selector in config) {
    $(selector).chosen(config[selector]);
  }

  // Our filter logic

  $('.tag-select').on('change', function() {
    $("div.lesson").hide();
    var activeFilters = getActiveFilters();
    $("div.lesson").each(function(){
      var $lesson = $(this);
      var lessonFilters = $lesson.data("tags");
      if(lessonQualified(activeFilters, lessonFilters)){
        $lesson.show();
      }
    });
  });

  function getActiveFilters(){
    var filterArray = [];
    $(".tag-select > option:selected").each(function(){
      filterArray.push(parseInt($(this).attr("id")));   
    });
    return filterArray;
    console.log(filterArray);
  };

  function lessonQualified(filter, lesson){
   for(var i = 0; i < filter.length ; i++){
     if((lesson.indexOf(filter[i])) == -1){
       return false;
     }
   }
   return true;
 };

});
 

// // Code for filtering by category
//   $("#filters :checkbox").click(function () {
//     $("li").hide();
//     var activeFilters = getActiveFilters();
//     $(".lesson").each(function () {
//       var $lesson = $(this);
//       var lessonFilters = $lesson.data("filters");
//       if (lessonQualified(activeFilters, lessonFilters)) {
//         $lesson.show();
//       }
//     });
//   });

//   function getActiveFilters() {
//     var filterArray = [];
//     $("#filters :checkbox:checked").each(function () {
//       filterArray.push(parseInt($(this).attr("id")));
//     });
//     return filterArray;
//   }

//   function lessonQualified(filter, lesson) {
//     for (var i = 0; i < filter.length; i++) {
//       if ((lesson.indexOf(filter[i])) == -1) {
//         return false;
//       }
//     }
//     return true;
//   }



// $(document).ready(function(){
//   $("a#show_all").on("click", function(e){
//     e.preventDefault();
//     $('div.jumbotron').show();
//   });

//   $("a#no_students").on("click", function(e){
//     e.preventDefault();
//     $('div.jumbotron').hide();
//     $("div[data-students='0']").show();
//   });

//   $("a#no_teachers").on("click", function(e){
//     e.preventDefault();
//     $('div.jumbotron').hide();
//     $("div[data-teachers='0']").show();
//   });



//   $("a#on_campus").on("click", function(e){
//     e.preventDefault();
//     $('div.jumbotron').hide();
//     $("div[data-location='campus']").show();
//   });

//   $("a#remote").on("click", function(e){
//     e.preventDefault();
//     $('div.jumbotron').show();
//     $("div[data-location='campus']").hide();
//     $("div[data-location='virtual']").hide();
//   });

//   $("a#virtual").on("click", function(e){
//     e.preventDefault();
//     $('div.jumbotron').hide();
//     $("div[data-location='virtual']").show();
//   });



//   $("ul#tags").on("click", "li a", function(e){
//     e.preventDefault();
//     var selected_tag = $(this).attr("data-tag");

//     $('div.jumbotron').hide();

//     $('div.jumbotron').each(function(){
//       // var tags_array = $(this).attr("data-tags").split(", "); 
//       if ($(this).attr("data-tags").toLowerCase().indexOf(selected_tag) >= 0){
//         $(this).show();
//       }

//     });
//   });

// });