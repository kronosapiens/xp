class TagsController < ApplicationController
  before_action :login_required, only: [:create]

  def index
    get_tags(:used)
    @language_tags = Tag.all_by_category("language") # override :used to get all language tags
    @tag = Tag.new
  end

  def show
    set_tag
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      flash[:alert] = "#{@tag.name} tag created!"
      redirect_to :back
    else
      flash[:error] = "Tag creation failed..."
      redirect_to :back
    end
  end

  private
  def set_tag
    @tag = Tag.find_by(:slug => params[:slug])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end