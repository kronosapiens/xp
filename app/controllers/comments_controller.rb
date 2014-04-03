class CommentsController < ApplicationController
  before_action :login_required
  # before_action :permission_check, only: :destroy

  def create
    @comment = Comment.new(:user_id => current_user.id, :content => params[:content])
    @comment.lesson_id = params[:lesson_id]

    if @comment.save
      @lesson = Lesson.find(params[:lesson_id])
      redirect_to @lesson #:back
    else
      render "lessons/show"
    end
  end 

  def destroy
    @comment = Comment.find(params[:id])
  
    if permitted && @comment.destroy
      respond_to do |format|
        format.html { redirect_to :back, :notice => "Commented deleted successfully" }
        format.json { head :no_content }
      end
    else
      flash[:notice] = "Can't delete someone else's comment!"
      redirect_to :back
    end
  end

  private 
    def permitted
      current_user == @comment.user 
    end

end