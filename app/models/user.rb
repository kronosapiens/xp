class User < ActiveRecord::Base
  has_many :registrations, :dependent => :destroy
  has_many :lessons, :through => :registrations

  has_many :comments

# Class Methods
  def self.find_or_create_by_oauth(auth_hash)
    where(:provider => auth_hash["provider"], :uid => auth_hash["uid"]).first ||
    create_by_oauth(auth_hash)
  end

  def self.create_by_oauth(auth_hash)
    new.tap do |u|
      u.provider = auth_hash["provider"]
      u.uid = auth_hash["uid"]
      u.name = auth_hash["info"]["name"]
      u.nickname = auth_hash["info"]["nickname"]
      u.email = auth_hash["info"]["email"]
      u.image_url = auth_hash["info"]["image"]
      u.save
    end
  end

  def self.ranked_by_tag_and_role(tag, role)
    self.joins(:lessons => :tags).where("registrations.role = '#{role}'").where("tags.id = '#{tag.id}'").group('users.id', 'tags.id').order('count(*) DESC')
  end

# Instance Methods
  def lessons_by_role(role)
    registrations.where(:role => role).map(&:lesson)
  end

  def lessons_by_role_and_status(role, status)
    my_registrations = self.registrations.where(:role => role).select do |registration|
      registration.lesson.status == status
    end
    my_registrations.map(&:lesson)
  end

  def all_instances_of_tag(tag)
    Tag.all_by_user(tag, self)
  end

  def add_to_completed(lesson)
    # binding.pry
  end


end