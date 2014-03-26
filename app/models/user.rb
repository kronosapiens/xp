class User < ActiveRecord::Base
  has_many :user_lessons, :dependent => :destroy
  has_many :lessons, :through => :user_lessons


  def lessons_as_student
    lessons.where(:role => "student")
  end

end
