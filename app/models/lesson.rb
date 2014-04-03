# class LessonValidator < ActiveModel::Validator 
#   # params[:role] == "student" && (params[:lesson][:locations] != nil || params[:lesson][:times] != nil) 
#   def validate(lesson)
#     if lesson.
#   end

# end 

class Lesson < ActiveRecord::Base
  include ActiveSupport::Inflector

  has_many :lesson_tags, :dependent => :destroy
  has_many :tags, :through => :lesson_tags

  has_many :registrations, :dependent => :destroy
  has_many :users, :through => :registrations

  has_many :comments

  # validates_with LessonValidator

  def build_tags(tags_hash)
    tags_hash.each do |category, tags|
      if tags
        tags.each do |tag|
          @this_tag = Tag.find_by(:name=> tag, :category => category.to_s.singularize)
          @this_tag.lesson_tags.create(:lesson_id => self.id)
        end
      end
    end   
  end

  def students
    registrations.where(:role => "student").map(&:user)
  end

  def teachers
    teachers_collection.map(&:user)
  end

  def all_tags
    lesson_tags.map(&:tag)
  end

  def topic_tags 
    tags.where(category: "topic")
  end 

  def location_tags
    tags.where(category: "location")
  end

  def time_tags
    tags.where(category: "time")
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

  def admin
    registration = registrations.where(:admin => true).first
    registration ? registration.user : nil
  end

  private
  def teachers_collection
    registrations.where(:role => "teacher")
  end

end
