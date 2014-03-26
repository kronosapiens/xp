class Lesson < ActiveRecord::Base
  has_many :lesson_tags, :dependent => :destroy
  has_many :tags, :through => :lesson_tags

  has_many :user_lessons, :dependent => :destroy
  has_many :users, :through => :user_lessons

  def students
    UserLesson.where(:role => "student").map{|userlesson| userlesson.user}
  end

  def teachers
    UserLesson.where(:role => "teacher").map{|userlesson| userlesson.user}
  end
end
