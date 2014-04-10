class Lesson < ActiveRecord::Base
  include ActiveSupport::Inflector

  has_many :lesson_tags, :dependent => :destroy
  has_many :tags, :through => :lesson_tags

  has_many :registrations, :dependent => :destroy
  has_many :users, :through => :registrations

  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  validates :references, presence: true
  validate :has_tags

  before_save do
    self.slug = slugify(self.title)
  end

  # Class Methods
  def self.all_by_status(status)
    where(:status => status)
  end

  # Instance Methods
  def ok_to_delete?
    registrations.length > 1
  end

  def has_tags
    if self.tags.length == 0
      errors.add(:tags, "Lesson must have at least one tag.")
    end
  end
   
  def build_tags(tags_array)
    tags_array.each do |tag_id|
      self.tags << Tag.find(tag_id.to_i)
    end
  end

  # def build_tags(tags_hash)
  #   tags_hash.each do |category, tags|
  #     if tags
  #       tags.each do |tag|
  #         @this_tag = Tag.where(:name=> tag, :category => category.to_s.singularize).first_or_create
  #         self.lesson_tags.build(:tag => @this_tag)
  #       end
  #     end
  #   end   
  # end

  def students
    registrations.where(:role => "student").map(&:user)
  end

  def teachers
    teachers_collection.map(&:user)
  end

  # def all_tags
  #   lesson_tags.map(&:tag)
  # end

  def topic_tags 
    tags.where(category: "topic")
  end 

  def location_tags
    tags.where(category: "location")
  end

  def time_tags
    tags.where(category: "time")
  end

  def tags_by_category(category)
    tags.where(category: category)
  end

  def tags_to_string
    tags.inject(""){|tag_string, tag| tag_string << tag.name + ", "}.chop.chop
  end

  def tag_ids_to_array
    tags.inject([]){|tag_array, tag| tag_array << tag.id}
  end

  def first_teacher
    teachers_collection.limit(1).first.user
  end

  def admin
    registration = registrations.where(:admin => true).first
    registration ? registration.user : nil
  end

  def close
    self.update(:status => "closed")
  end

  def open
    self.update(:status => "open")
  end

  def mark_completed
    self.update(:status => "completed")
    self.users.each {|user| user.add_to_completed(self)}
  end

  private
  def teachers_collection
    registrations.where(:role => "teacher")
  end

  def slugify(string)
    string.downcase.gsub(" ", "-")
  end

end
