function joinLesson(registered_html){
  $("div#registration-info").html(registered_html);
};

function leaveLesson(unregistered_html){
  $("div#registration-info").html(unregistered_html);
};

function updateCurrentRegistrants(current_registrants_html){
  $("div#current-registrants").html(current_registrants_html);
}