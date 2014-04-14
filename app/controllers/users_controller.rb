class UsersController < ApplicationController

  def show 
    @user = User.find_by(nickname: params[:nickname])
  end

  def edit
    @user = User.find_by(nickname: params[:nickname])
  end 

  # def update 
  #   @user = User.find_by(nickname: params[:nickname])
  #   @user.update(:email => params[:email])
  #   redirect_to root_path
  # end 

end
