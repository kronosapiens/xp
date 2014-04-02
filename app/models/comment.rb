class Comment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user

end 