class UserLessonsController < ApplicationController
  before_action :login_required

  def create
    @user_lesson = UserLesson.new(user_lesson_params)
    @user_lesson.user_id = current_user.id
    @lesson = Lesson.find(@user_lesson.lesson_id)

    respond_to do |format|
      if @user_lesson.save
        format.html { redirect_to @lesson, notice: 'Sign Up Successful!' }
        format.json { render action: 'show', status: :created, location: @lesson }
      else
        format.html { redirect_to @lesson, notice: 'Sign Up Failed. Keep trying! :(' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_lesson_params
      params.require(:user_lesson).permit(:role, :lesson_id)
    end

  end
