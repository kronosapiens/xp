$(document).ready(function () {

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

  $("#student-button").on('change', function(){
    $("#teacher-button").parents(".btn").removeClass( "active" );
    $('#teacher-button').prop('checked', false);
    filterLessons();
  });

  $("#teacher-button").on('change', function(){
    $("#student-button").parents(".btn").removeClass( "active" );
    $('#student-button').prop('checked', false);
    filterLessons();
  });

  $('.chosen-index').on('change', function() {
    filterLessons();
  });

  function filterLessons(){
    $("div.lesson").parents(".lesson-wrapper").hide();
    var activeFilters = getActiveFilters();
    $("div.lesson").each(function(){
      var $lesson = $(this);
      var lessonFilters = $lesson.data("tags");
      var studentCount = $lesson.data("students");
      var teacherCount = $lesson.data("teachers");
      if(filterCheck(activeFilters, lessonFilters) && interestCheck(studentCount, teacherCount)){
        $lesson.parents(".lesson-wrapper").show();
      }
    });
  };

  function interestCheck(studentCount, teacherCount){
    var interestID = $(".interest-filter:checked").attr("id");
    if(interestID == undefined){
      return true;
    }else if((interestID == "student-button") && (studentCount == 0)){
      return true;
    }else if((interestID == "teacher-button") && (teacherCount == 0)){
      return true;
    }else{
      return false;
    };
  };

  function getActiveFilters(){
    var filterArray = [];
    $(".chosen-index :checked").each(function(){
      filterArray.push(parseInt($(this).attr("id")));   
    });
    return filterArray;
    console.log(filterArray);
  };

  function filterCheck(filters, lesson){
    for(var i = 0; i < filters.length ; i++){
     if((lesson.indexOf(filters[i])) == -1){
       return false;
     }
   }
   return true;
 };

});