class Lesson < ActiveRecord::Base
  has_many :lesson_tags, :dependent => :destroy
  has_many :tags, :through => :lesson_tags

  has_many :user_lessons, :dependent => :destroy
  has_many :users, :through => :user_lessons

  def students
    user_lessons.where(:role => "student").map{|userlesson| userlesson.user}
  end

  def teachers
    user_lessons.where(:role => "teacher").map{|userlesson| userlesson.user}
  end

end
