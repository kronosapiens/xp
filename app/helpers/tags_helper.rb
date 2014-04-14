module TagsHelper

  def all_students
    User.ranked_by_tag_and_role(@tag, "student")
  end

  def all_teachers
    User.ranked_by_tag_and_role(@tag, "teacher")
  end

  def all_by_level
    @tag.experiences.order_by_level
  end
  
end
