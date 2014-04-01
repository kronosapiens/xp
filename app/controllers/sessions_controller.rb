class SessionsController < ApplicationController

  def oauth
    user = User.find_or_create_by_oauth(request.env["omniauth.auth"])
    login(user)
    redirect_to root_path
  end

  def login(user)
    session[:user_id] = user.id
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
