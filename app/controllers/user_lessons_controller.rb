class UserLessonsController < ApplicationController
  before_action :login_required
  before_action :set_user_lesson, only: [:edit, :update, :destroy]


  def create
    @user_lesson = UserLesson.new(user_lesson_params)
    @user_lesson.lesson_id = params[:lesson_id]
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

  def update
    @lesson = Lesson.find(@user_lesson.lesson_id)

    respond_to do |format|
      if @user_lesson.update(user_lesson_params)
        format.html { redirect_to @lesson, notice: 'Your registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @lesson, notice: 'You cannot update your registration right now.' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_lesson
      @user_lesson = UserLesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_lesson_params
      params.require(:user_lesson).permit(:lesson_id, :user_id, :role, :admin)
    end

  end
