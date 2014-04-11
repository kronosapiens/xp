class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= (session[:user_id] ? User.find(session[:user_id]) : nil)
  end
  helper_method :current_user

  def login_required
    unless logged_in?
      respond_to do |format|
        format.html do
          flash[:alert] = "You must be logged in to take this action. Please <a href='#{login_path}'>log in</a> and try again."
          redirect_to :back
        end
        format.js {} # Implement the js to create a login-in prompt in response to js requests
      end
    end
  end

  def logged_in?
    !!session[:user_id]
  end
  helper_method :logged_in?

  def is_user_admin?(lesson)
    current_user && lesson.admin == current_user
  end
  helper_method :is_user_admin?

  def permitted_to_delete_comment?(comment)
    current_user == comment.user || current_user == @lesson.admin
  end
  helper_method :permitted_to_delete_comment?

  def get_tags(scope = :all)
    @language_tags = Tag.all_by_category("language").send(scope)
    @location_tags = Tag.all_by_category("location").send(scope)
    @time_tags = Tag.all_by_category("time").send(scope)
    @topic_tags = Tag.all_by_category("topic").send(scope)
  end

  if Rails.env.test?
    prepend_before_filter :stub_session_user_id
    def stub_session_user_id
      session[:user_id] = $rspec_user_id if $rspec_user_id
    end
  end
  
end
