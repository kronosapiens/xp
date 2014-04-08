class RegistrationsController < ApplicationController
  before_action :login_required
  before_action :set_registration, only: [:edit, :update, :destroy]
  before_action :set_lesson, only: [:update, :destroy]



  def create
    @registration = Registration.new(registration_params)
    @registration.lesson_id = params[:lesson_id]
    @registration.user = current_user
    set_lesson

    respond_to do |format|
      if @registration.save
        format.html { redirect_to @lesson, notice: 'Sign up successful!' }
        format.js {}
        format.json { render action: 'show', status: :created, location: @lesson }
      else
        format.html { redirect_to @lesson, alert: 'Sign up failed... are you already signed up?' }
        format.js { redirect_to @lesson, alert: 'Sign up failed... are you already signed up?' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to @lesson, notice: 'Your registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @lesson, alert: 'Update registration failed...' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @registration.destroy
    
    respond_to do |format|
      format.html { redirect_to @registration.lesson, notice: 'You are no longer registered for this lesson.' }
      format.js {}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def set_lesson
      @lesson = Lesson.find(@registration.lesson_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:lesson_id, :user_id, :role, :admin)
    end

  end
