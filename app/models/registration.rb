class RegistrationValidator < ActiveModel::Validator
  def validate(registration)
    this_lesson = Lesson.find(registration.lesson_id)
    if registration.admin == true && this_lesson.admin
      registration.errors[:admin] << "Lesson can only have one admin at a time"
    end
  end
end

class Registration < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :user
  belongs_to :lesson

  validates_uniqueness_of :user, :scope => :lesson, :error => "Can't sign up for the same lesson twice!"
  validates_with RegistrationValidator
end

