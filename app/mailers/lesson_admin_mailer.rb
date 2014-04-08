class LessonAdminMailer < ActionMailer::Base
  default from: "xp.schedulebot@gmail.com"

  # def signup_welcome(user)
  #   @user = user
  #   mail(to: @user.email, subject: 'Welcome to xp')
  # end

  def admin_message(lesson, subject, content)
    @lesson = lesson
    @subject = subject
    @content = content

    email_array = lesson.users.map do |user|
      user.email if user.email
    end
    mail(to: email_array.join("; "), subject: @subject)
  end
end
