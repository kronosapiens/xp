class UsersController < ApplicationController

  def show 
    @user = User.find_by(session[:user_id])
  end

end
