class Tag < ActiveRecord::Base
  has_many :lesson_tags, :dependent => :destroy
  has_many :lessons, :through => :lesson_tags

  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false

  before_save do
    self.slug = slugify(self.name)
  end

  def self.all_by_user(tag, user)
    self.joins(:lessons => :users).where("tags.id = '#{tag.id}'").where("users.id = '#{user.id}'")
  end

  def self.all_by_category(category)
    where(:category => category)
  end

  def upcoming_lessons
    lessons.where(:status => "open") + lessons.where(:status => "closed")
  end

  def completed_lessons
    lessons.where(:status => "completed")
  end

  private
  def slugify(string)
    string.downcase.gsub(" ", "-")
  end

end
