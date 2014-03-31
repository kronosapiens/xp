class LessonTag < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :tag
end
