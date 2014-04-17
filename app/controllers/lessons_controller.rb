class LessonsController < ApplicationController
  before_action :login_required, except: [:index, :show]
  before_action :set_lesson, only: [:show, :edit, :update, :update_status, :destroy]
  before_action only: [:new, :edit, :show, :update, :create] do
    get_tags
  end

  def index
    get_tags(:active)
    @lessons = Lesson.all_by_status("open")
  end

  def show
    @registration = (current_user ? get_registration : nil)
    @comment = Comment.new
  end

  def new
    @role = params[:role]
    @lesson = Lesson.new
    @tag = Tag.new
  end

  def edit
    if is_user_admin?(@lesson)
      render :edit
    else
      flash[:alert] = "Can't edit unless admin!"
      redirect_to @lesson
    end
  end

  def create
    @lesson = Lesson.new(lesson_params)
    tags = params[:lesson][:tags]
    @lesson.build_tags(tags) if tags

    respond_to do |format|
     if @lesson.save
      @lesson.registrations.create(:user => current_user, :role => params[:role])
      format.html { redirect_to @lesson, notice: 'Lesson was successfully created!' }
     else
      @tag = Tag.new
      @role = params[:role]
      format.html { render action: 'new' }
      end
    end
  end

  def update
      @lesson.tags.clear
      @lesson.build_tags(params[:lesson][:tags])
      params[:lesson][:specific_time] = Chronic.parse(params[:lesson][:specific_time]) + 4.hours

    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.js {}
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

# Specific route for updating the lesson's status (accessed via buttons from the Admin panel)
  def update_status
    @registration = get_registration
    respond_to do |format|
      if @lesson.update(lesson_params)
        @lesson.mark_completed_for_users if @lesson.status == "completed"
        format.html { redirect_to @lesson, notice: "Lesson status successfully updated to '#{params[:lesson][:status]}'." }
        format.js {}
      else
        format.html { redirect_to @lesson, alert: "Unable to change lesson status" }
        format.js { redirect_to @lesson, alert: "Unable to change lesson status" }
      end
    end
  end

  def destroy
    if @lesson.ok_to_delete?
      if is_user_admin?(@lesson)
        @lesson.destroy
        respond_to do |format|
          format.html { redirect_to lessons_url }
          # format.js {}
        end
      else
        flash[:alert] = "Can't delete unless admin!"
        redirect_to @lesson
      end
    else
      flash[:alert] = "Can't delete if there are other users signed up."
      redirect_to @lesson
    end
  end

  def admin_email
    set_lesson
    if is_user_admin?(@lesson)
      subject = params[:subject]
      content = params[:content]
      LessonAdminMailer.admin_message(@lesson, subject, content).deliver
      redirect_to @lesson, notice: 'Email was sent!' 
    else
      flash[:alert] = "Only lesson admins can send emails to the whole class"
      redirect_to @lesson
    end
  end

  private
  def set_lesson
    if params[:id].to_i > 0
      @lesson = Lesson.find(params[:id])
    else
      @lesson = Lesson.find_by(:slug => params[:id])
    end
  end

  def get_registration
    Registration.find_by(user: current_user, lesson: @lesson)
  end

  def lesson_params
    params.require(:lesson).permit(:title, :description, :references, :specific_location, :specific_time, :status)
  end

end
