class User < ActiveRecord::Base
  has_many :registrations, :dependent => :destroy
  has_many :lessons, :through => :registrations
  has_many :experiences, :dependent => :destroy
  has_many :tags, :through => :experiences

  has_many :comments

# Class Methods
  def self.find_or_create_by_oauth(auth_hash)
    provider = auth_hash["provider"]
    uid = auth_hash["uid"]
    auth_token = auth_hash["credentials"]["token"]
    user = where(:provider => provider, :uid => uid).first

    if !user
      create_by_oauth(auth_hash)
    else
      user.update(:token => auth_token)
      user
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
    Tag.all_by_user(self).where("tags.id = '#{tag.id}'")
  end

  def add_to_completed(lesson)
    role = self.registrations.where(:lesson => lesson).first.role
    lesson.tags.each do |tag|
      experience = self.experiences.find_or_create_by(:tag => tag)
      if role == "teacher"
        experience.taught += 1
      elsif role == "student"
        experience.taken += 1
      end
      experience.save
    end
  end

  def experience_with(name)
    tag = Tag.find_by(:name => name)
    experiences.where(:tag => tag).first
  end

  def update_xp(languages_array) #coming in as an array of hashes
    languages_array.each do |languages_hash_for_repo|
      languages_hash_for_repo.each do |language, lines_of_code|
        tag = Tag.find_or_create_by(:name => language.to_s)
        experience = self.experiences.find_or_create_by(:tag => tag)
        prior_gh_stat = experience.gh_stat
        experience.update(:gh_stat => prior_gh_stat + lines_of_code)
      end
    end
  end

  def clear_gh_stats
    experiences.each do |experience|
      experience.update(:gh_stat => 0)
    end
  end

  private
  def self.create_by_oauth(auth_hash)
    new.tap do |u|
      u.provider = auth_hash["provider"]
      u.uid = auth_hash["uid"]
      u.name = auth_hash["info"]["name"]
      u.nickname = auth_hash["info"]["nickname"]
      u.email = auth_hash["info"]["email"]
      u.image_url = auth_hash["info"]["image"]
      u.token = auth_hash["credentials"]["token"]
      u.save
    end
  end

end