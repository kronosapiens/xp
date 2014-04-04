module LessonsHelper

  def prepopulate_tags(lesson, tag)
    "selected" if lesson.tag_ids_to_array.include?(tag.id)
  end

  def generate_tag_option(tag)
    "<option id='#{tag.id}'>#{tag.name}</option>"
  end

  def admin?(lesson, user)
    user && (lesson.admin == user)
  end

  def display_location(lesson) 
    if lesson.specific_location && lesson.specific_location != ""
      lesson.specific_location
    else
      "TDB"
    end
  end

  def display_time(lesson) 
    if lesson.specific_time && lesson.specific_time != ""
      lesson.specific_time.to_formatted_s(:long_ordinal)
    else
      "TDB"
    end

  def one_user?(lesson)
    lesson.registrations.length == 1
  end

end
