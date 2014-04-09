module TagsHelper

  def all_students
    User.ranked_by_tag_and_role(@tag, "student")
  end

  def all_teachers
    User.ranked_by_tag_and_role(@tag, "teacher")
  end

  def top_5_teachers
    all_teachers.limit(5)
  end

  def top_5_students
    all_students.limit(5)
  end
  
end
