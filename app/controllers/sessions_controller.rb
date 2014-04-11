class SessionsController < ApplicationController
  
  def login(user)
    session[:user_id] = user.id
  end

  def oauth
    user = User.find_or_create_by_oauth(request.env["omniauth.auth"])
    login(user)
    if user.email == nil 
      redirect_to user_edit_path
    else
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
  
end
