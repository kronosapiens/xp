class Comment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true  
end 