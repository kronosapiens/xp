class SessionsController < ApplicationController

  def oauth
    user = User.find_or_create_by_oauth(request.env["omniauth.auth"])
    login(user)
    redirect_to root
  end

end
