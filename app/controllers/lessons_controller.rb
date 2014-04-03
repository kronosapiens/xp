class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
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
    @registration = (current_user ? get_registration : nil)
    @admin = @lesson.admin
    @is_admin = current_user && @admin == current_user
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
    @lesson.build_tags(tags_hash)

    respond_to do |format|
     if @lesson.save
       @lesson.registrations.create(:user => current_user, :role => params[:role])
       format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
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
        @lesson.lesson_tags.clear
        tags_hash = {
          :topics => params[:lesson][:topics],
          :locations => params[:lesson][:locations],
          :times => params[:lesson][:times]
        }
        @lesson.build_tags(tags_hash)
        
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

    def get_registration
      Registration.find_by(user_id: current_user.id, lesson_id: @lesson.id)
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
