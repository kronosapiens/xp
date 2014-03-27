class Lesson < ActiveRecord::Base
  has_many :lesson_tags, :dependent => :destroy
  has_many :tags, :through => :lesson_tags

  has_many :user_lessons, :dependent => :destroy
  has_many :users, :through => :user_lessons

  def students
    user_lessons.where(:role => "student").map(&:user)
  end

  def teachers_from_arel
    user_lessons.where(:role => "teacher")
  end

  def teachers
    teachers_from_arel.map(&:user)
  end

  def all_tags
    lesson_tags.map(&:tag)
  end

  def tags_to_string
    all_tags.inject(""){|tag_string, tag| tag_string << tag.name + ", "}.chop.chop
  end

  def first_teacher
    teachers_from_arel.limit(1).first.user
  end

end
