class TagsController < ApplicationController
  
  def new 
    @tag = Tag.new
  end

  def show
    set_tag
  end

  def create
    @tag = Tag.new(:name => params[:name], :category => "topic")

    if @tag.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private
  def set_tag
    @tag = Tag.find(params[:id])
  end


end