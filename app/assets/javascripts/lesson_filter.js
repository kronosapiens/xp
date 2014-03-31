$(document).ready(function () {

// Code for filtering by teacher/student status

// $("a#show_all").on("click", function(e){
//   e.preventDefault();
//   $('li').show();
// });

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