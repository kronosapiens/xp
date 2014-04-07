class User < ActiveRecord::Base
  has_many :registrations, :dependent => :destroy
  has_many :lessons, :through => :registrations

  has_many :comments


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

  def lessons_as_student
    registrations.where(:role => "student").map(&:lesson)
  end

  def lessons_as_teacher
    registrations.where(:role => "teacher").map(&:lesson)
  end

  def lessons_by_role_and_status(role, status)
    self.lessons.where(:status => status).select do |lesson|
      (lesson.registrations.where(:role => role) && lesson.registrations.where(:user_id => self.id))
    end
  end

  # def lessons_by_role_and_status(role, status)
  #   self.lessons.where(:status => status).select do |lesson|
  #     lesson.registrations.where(:role => role, :user_id => self.id)
  #   end
  # end

  def open_lessons_as_student
    self.lessons.where(:status => "open").select do |lesson|
      lesson.registrations.where(:role => "student").where(:user_id => self.id)
    end
  end

  def open_lessons_as_teacher
    self.lessons.where(:status => "open").select do |lesson|
      lesson.registrations.where(:role => "teacher", :user_id => self.id)
    end
  end


end