class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :set_user_lesson, only: [:edit, :show]
  before_action :get_tags, only: [:index, :new, :edit, :show]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
    # stuff for sending tag data to the index
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @is_admin = @lesson.admin == current_user
    @comment = Comment.new
  end

  # GET /lessons/new
  def new
    @role = params[:role]
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create 
    @lesson = Lesson.new(lesson_params)
    tags_hash = {
      :topics => params[:lesson][:topics],
      :locations => params[:lesson][:locations],
      :times => params[:lesson][:times]
    }

    if params[:role] == "student" && (params[:lesson][:locations] != nil || params[:lesson][:times] != nil) 
      render action: 'new', notice: "Students may not specify location or time."
      # render action: 'new', errors.add(:my_error, "students tryn be tricky")
    else
      respond_to do |format|
        if @lesson.save
           @lesson.build_tags(tags_hash)
           @lesson.user_lessons.create(:user_id => current_user.id, :role => params[:role])
          

          format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
          format.json { render action: 'show', status: :created, location: @lesson }
        else
          format.html { render action: 'new' }
          format.json { render json: @lesson.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def set_user_lesson
      @user_lesson = UserLesson.find_by(lesson_id: @lesson.id, user_id: current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:title, :description, :references)
    end

    def get_tags
      @topic_tags = Tag.all_topics
      @location_tags = Tag.all_locations
      @time_tags = Tag.all_times
    end

end
