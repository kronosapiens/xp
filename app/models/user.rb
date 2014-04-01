class User < ActiveRecord::Base
  has_many :user_lessons, :dependent => :destroy
  has_many :lessons, :through => :user_lessons


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

    #   t.string   "name"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.string   "provider"
    # t.string   "uid"
    # t.string   "nickname"
    # t.string   "email"
    # t.string   "image_url"

  def lessons_as_student
    user_lessons.where(:role => "student").map(&:lesson)
  end

  def lessons_as_teacher
    user_lessons.where(:role => "teacher").map(&:lesson)
  end

end