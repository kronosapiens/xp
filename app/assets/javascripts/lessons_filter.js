$(".lessons .index").ready(function () {

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

  $('.tag-select').on('change', function() {
    filterLessons();
  });

  function filterLessons(){
    $("div.lesson").hide();
    var activeFilters = getActiveFilters();
    $("div.lesson").each(function(){
      var $lesson = $(this);
      var lessonFilters = $lesson.data("tags");
      var studentCount = $lesson.data("students");
      var teacherCount = $lesson.data("teachers");
      if(filterCheck(activeFilters, lessonFilters) && interestCheck(studentCount, teacherCount)){
        $lesson.show();
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
    $(".tag-select :checked").each(function(){
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