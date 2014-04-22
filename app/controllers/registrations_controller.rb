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
      else
        format.html { to_lesson_with_alert('Sign up failed... are you already signed up?') }
        format.js { to_lesson_with_alert('Sign up failed... are you already signed up?') }
      end
    end
  end

  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to @lesson, notice: 'Your registration was successfully updated.' }
        format.js {}
      else
        format.html { to_lesson_with_alert('Update registration failed...') }
        format.js { to_lesson_with_alert('Update registration failed...') }
      end
    end
  end

  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to @registration.lesson, notice: 'You are no longer registered for this lesson.' }
      format.js {}
    end
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def set_lesson
      @lesson = Lesson.find(@registration.lesson_id)
    end

    def registration_params
      params.require(:registration).permit(:lesson_id, :user_id, :role, :admin)
    end

  end
