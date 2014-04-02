class CommentsController < ApplicationController
  before_action :login_required

  def create
    @lesson = Lesson.find(params[:lesson_id])
    # @lesson.comments.build(:user_id => params[:user_id], :content => params[:content])
    @comment = Comment.new(:user_id => current_user.id, :content => params[:content])
    @comment.lesson_id = params[:lesson_id]

    if @comment.save
      redirect_to :back
    else
      # redirect_to :back
      render "lessons/show"
    end
  end 

end