class UserLesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson

  validates_uniqueness_of :lesson, :scope => :user, :error => "my error"

end
