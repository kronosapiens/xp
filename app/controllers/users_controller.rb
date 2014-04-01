class UsersController < ApplicationController

  def show 
    @user = User.find_by(sessons[:user_id])
  end

end
