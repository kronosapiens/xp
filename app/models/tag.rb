class Tag < ActiveRecord::Base
  has_many :lesson_tags, :dependent => :destroy
  has_many :lessons, :through => :lesson_tags

  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false

  def self.all_topics
    where(:category => "topic")
  end

  def self.all_times
    where(:category => "time")
  end

  def self.all_locations
    where(:category => "location")
  end

end
