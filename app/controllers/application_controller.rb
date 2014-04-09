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
      flash[:alert] = "You must be logged in to take this action. Please <a href='#{login_path}'>log in</a> and try again."
      redirect_to :back
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

  if Rails.env.test?
    prepend_before_filter :stub_session_user_id
    def stub_session_user_id
      session[:user_id] = $rspec_user_id if $rspec_user_id
    end
  end

  def get_tags
    @topic_tags = Tag.all_by_category("topic")
    @language_tags = Tag.all_by_category("language")
    @location_tags = Tag.all_by_category("location")
    @time_tags = Tag.all_by_category("time")
  end
  
end
