class Lesson < ActiveRecord::Base

  has_many :lesson_tags, :dependent => :destroy
  has_many :tags, :through => :lesson_tags

  has_many :registrations, :dependent => :destroy
  has_many :users, :through => :registrations

  has_many :comments

  validates :title, presence: true, length: { maximum: 50, too_long: " cannot be more than 50 characters" }
  validates :description, presence: true
  validates :references, presence: true
  validate :has_tags

  before_save :before_save_slugify

  # Class Methods
  def self.all_by_status(status)
    where(:status => status)
  end

  # Instance Methods
  def ok_to_delete?
    registrations.length <= 1
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

  def tags_by_category(category)
    tags.where(category: category)
  end

  def students
    registrations.where(:role => "student").map(&:user)
  end

  def teachers
    registrations.where(:role => "teacher").map(&:user)
  end

  # def tags_to_string
  #   tags.inject(""){|tag_string, tag| tag_string << tag.name + ", "}.chop.chop
  # end

  def tag_ids_to_array
    tags.inject([]){|tag_array, tag| tag_array << tag.id}
  end

  # def first_teacher
  #   teachers_collection.limit(1).first.user
  # end

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

  def mark_completed_for_users
    self.users.each {|user| user.add_to_completed(self)}
  end

  def before_save_slugify
    self.slug = slugify(self.title)
  end

  def specific_time=(time)
    write_attribute(:specific_time, parse_time(time))
  end

  private
  # def teachers_collection
  #   registrations.where(:role => "teacher")
  # end

  def slugify(string)
    string.downcase.gsub(" ", "-")
  end

  def parse_time(time)
    if time.class == String
      Chronic.parse(time)
    else
      time
    end
  end

end
