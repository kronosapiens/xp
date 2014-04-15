class SessionsController < ApplicationController
  
  def login(user)
    session[:user_id] = user.id
  end

  def oauth
    if flatiron_student?
      user = User.find_or_create_by_oauth(request.env["omniauth.auth"])
      login(user)
      redirect_to :back, notice: "Successfully logged in. Welcome to xp!"
    else
      redirect_to root_path, alert: "Must be a Flatiron student to use xp... (for now)."
    end
  end

  def destroy
    reset_session
    redirect_to lessons_path
  end

  def flatiron_student?
    client = Octokit::Client.new(:access_token => (request.env["omniauth.auth"]["credentials"]["token"]))
    client.organizations.map(&:id).include?(6207995)
  end
  
end
