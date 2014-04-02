class Comment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user

  # validates_presense_of :content, :user_id
  validates :content, presence: true
  validates :user_id, presence: true

end 