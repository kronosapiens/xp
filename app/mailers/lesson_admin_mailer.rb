class LessonAdminMailer < ActionMailer::Base
  default from: "from@example.com"

  def signup_welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def admin_message(lesson)
    @lesson = lesson
    email_array = lesson.users.map do |user|
      user.email if user.email
    end
    mail(to: email_array.join("; "), subject: 'Welcome to My Awesome Site')
  end
end
