class TagsController < ApplicationController

  def index
    get_tags
    @tag = Tag.new
  end

  def show
    set_tag
  end

  def create
    login_required
    @tag = Tag.new(:name => params[:name], :category => "topic")

    if @tag.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private
  def set_tag
    @tag = Tag.find_by(:slug => params[:slug])
  end

end