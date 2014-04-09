class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :update_status, :destroy]
  before_action :login_required, except: [:index, :show]
  before_action only: [:index, :new, :edit, :show] do
    get_tags(:active)
  end

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all_by_status("open")
    binding.pry
  end

  def admin_email
    set_lesson
    if is_user_admin?(@lesson)
      subject = params[:subject]
      content = params[:content]
      LessonAdminMailer.admin_message(@lesson, subject, content).deliver

      redirect_to @lesson, notice: 'Email was sent!' 
      # redirect_to :back
    else
      flash[:alert] = "Only lesson admins can send emails to the whole class"
      redirect_to @lesson
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @registration = (current_user ? get_registration : nil)
    @comment = Comment.new
  end

  # GET /lessons/new
  def new
    @role = params[:role]
    @lesson = Lesson.new
    @tag = Tag.new
  end

  # GET /lessons/1/edit
  def edit
    if is_user_admin?(@lesson)
      render :edit
    else
      flash[:alert] = "Can't edit unless admin!"
      redirect_to @lesson
    end
  end

  # POST /lessons
  # POST /lessons.json
  def create 
    tags_hash = tag_hash_from_params(params)
    @lesson = Lesson.new(lesson_params)
    @lesson.build_tags(tags_hash)

    respond_to do |format|
     if @lesson.save
       @lesson.registrations.create(:user => current_user, :role => params[:role])
       format.html { redirect_to @lesson, notice: 'Lesson was successfully created!' }
       format.json { render action: 'show', status: :created, location: @lesson }
     else
      get_tags
      @tag = Tag.new
      format.html { render action: 'new' }
      format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    # unless params[:lesson][:status]
      @lesson.lesson_tags.clear

      tags_hash = tag_hash_from_params(params)
      @lesson.build_tags(tags_hash)
          
      params[:lesson][:specific_time] = Chronic.parse(params[:lesson][:specific_time])
    # end

    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.js {}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

# Specific route for updating the lesson's status (accessed via buttons from the Admin panel)
  def update_status
    @registration = get_registration
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: "Lesson status successfully updated to '#{params[:lesson][:status]}'." }
        format.js {}
        format.json { head :no_content }
      else
        format.html { redirect_to @lesson, alert: "Unable to change lesson status" }
        format.js { redirect_to @lesson, alert: "Unable to change lesson status" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    if @lesson.ok_to_delete?
      if is_user_admin?
        @lesson.destroy
        respond_to do |format|
          format.html { redirect_to lessons_url }
          format.json { head :no_content }
        end
      else
        flash[:alert] = "Can't delete unless admin!"
        redirect_to @lesson
      end
    else
      errors.add(:base, "Can't delete if there are other users signed up.")
      redirect_to @lesson
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lesson
    # if params[:id].is_a?(Integer)
      @lesson = Lesson.find(params[:id])
    # else
    #   @lesson = Lesson.find_by(:slug => params[:id])
    # end
  end

  def get_registration
    Registration.find_by(user: current_user, lesson: @lesson)
    # Registration.find_by(user_id: current_user.id, lesson_id: @lesson.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def lesson_params
    params.require(:lesson).permit(:title, :description, :references, :specific_location, :specific_time, :status)
  end

  def tag_hash_from_params(params)
    {
      :topics => params[:lesson][:topics],
      :locations => params[:lesson][:locations],
      :times => params[:lesson][:times]
    }
  end

end
