class SessionsController < ApplicationController

  def oauth
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_by_oauth(auth)
    login(user)
    redirect_to root_path, notice: "Successfully logged in. Welcome to xp!"
  end
  
    # if flatiron_student?(auth["credentials"]["token"])
    #   user = User.find_or_create_by_oauth(auth)
    #   login(user)
    #   redirect_to root_path, notice: "Successfully logged in. Welcome to xp!"
    # else
    #   redirect_to root_path, alert: "Must be a Flatiron student to use xp... (for now)."
    # end

  def destroy
    reset_session
    redirect_to root_path
  end
  
  def login(user)
    session[:user_id] = user.id
  end

  def flatiron_student?(token)
    client = Octokit::Client.new(:access_token => token)
    client.organizations.map(&:id).include?(6207995)
  end
  
end
