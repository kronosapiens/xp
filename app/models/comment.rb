class Comment < ActiveRecord::Base
  belongs_to :lesson

  def get_user(comment)
    User.find(comment.user_id)
  end 

end 