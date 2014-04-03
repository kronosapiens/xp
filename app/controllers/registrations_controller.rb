class RegistrationsController < ApplicationController
  before_action :login_required
  before_action :set_registration, only: [:edit, :update, :destroy]


  def create
    @registration = Registration.new(registration_params)
    @registration.lesson_id = params[:lesson_id]
    @registration.user_id = current_user.id
    @lesson = Lesson.find(@registration.lesson_id)

    respond_to do |format|
      if @registration.save
        format.html { redirect_to @lesson, notice: 'Sign Up Successful!' }
        format.json { render action: 'show', status: :created, location: @lesson }
      else
        format.html { redirect_to @lesson, notice: 'Sign Up Failed. Keep trying! :(' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @lesson = Lesson.find(@registration.lesson_id)

    respond_to do |format|
      if @registration.update(registration_params)
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
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:lesson_id, :user_id, :role, :admin)
    end

  end
