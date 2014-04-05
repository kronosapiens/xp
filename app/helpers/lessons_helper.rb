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
  end

  def prepopulate_time(lesson)
    if lesson.specific_time != nil && lesson.specific_time != ""
      return lesson.specific_time.to_formatted_s(:long_ordinal)
    else
      return ""
    end
  end

  def lesson_has_a_specific_time(lesson)
    lesson.specific_time != nil && lesson.specific_time != ""
  end

  def lesson_has_a_specific_location(lesson)
    lesson.specific_location != nil && lesson.specific_location != ""
  end

  def display_google_calendar_link(lesson)
    if lesson_has_a_specific_time(lesson) && lesson_has_a_specific_location(lesson)
      event_title = lesson.title.gsub(" ", "+")


      adjusted_lesson_time = lesson.specific_time# - 8.hours # crappy timezone/daylight savings time work-around

      start_date = adjusted_lesson_time.iso8601.gsub("-", "").gsub(":", "").split("+")[0]
      end_date = (adjusted_lesson_time + 2.hours).to_datetime.iso8601.gsub("-", "").gsub(":", "").split("+")[0]
      dates = "#{start_date}/#{end_date}Z"
      details = lesson.description.gsub(" ", "+")
      location = lesson.specific_location.gsub(" ", "+")

      href = "https://www.google.com/calendar/render?action=TEMPLATE&text=#{event_title}&dates=#{dates}&details=#{details}&location=#{location}&sf=true&output=xml"

      html = "<a href='#{href}' target='_blank' rel='nofollow'>Add this lesson to my Google calendar</a>".html_safe
      return html
    else
      return ""
    end
  end

  def one_user?(lesson)
    lesson.registrations.length == 1
  end

end
