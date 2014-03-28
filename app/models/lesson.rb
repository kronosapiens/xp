class Lesson < ActiveRecord::Base
  has_many :lesson_tags, :dependent => :destroy
  has_many :tags, :through => :lesson_tags

  has_many :user_lessons, :dependent => :destroy
  has_many :users, :through => :user_lessons

  def students
    user_lessons.where(:role => "student").map(&:user)
  end

  def teachers
    teachers_collection.map(&:user)
  end

  def all_tags
    lesson_tags.map(&:tag)
  end

  def tags_to_string
    all_tags.inject(""){|tag_string, tag| tag_string << tag.name + ", "}.chop.chop
  end

  def tag_ids_to_array
    all_tags.inject([]){|tag_array, tag| tag_array << tag.id}
  end

  def first_teacher
    teachers_collection.limit(1).first.user
  end

  private
  def teachers_collection
    user_lessons.where(:role => "teacher")
  end

end
