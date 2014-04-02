class UserLessonValidator < ActiveModel::Validator
  def validate(user_lesson)
    this_lesson = Lesson.find(user_lesson.lesson_id)
    if user_lesson.admin == true && this_lesson.admin
      user_lesson.errors[:admin] << "Lesson can only have one admin at a time"
    end
  end
end

class UserLesson < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :user
  belongs_to :lesson

  validates_uniqueness_of :user, :scope => :lesson, :error => "Can't sign up for the same lesson twice!"
  validates_with UserLessonValidator
end

