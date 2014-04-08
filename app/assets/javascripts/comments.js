function addCommentToLesson(comment_html){
  $("#comments-section").append(comment_html)
};

function deleteComment(comment_id){
  $("div#comment_"+comment_id).remove();
};