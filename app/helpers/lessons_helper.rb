module LessonsHelper

  def user_style(lesson)
    if current_user && current_user.role_for(lesson)
      "#{current_user.role_for(lesson)}-color"
    end
  end

  def one_user?(lesson)
    lesson.registrations.length == 1
  end

  def prepopulate_tags(lesson, tag)
    "selected" if lesson.tag_ids_to_array.include?(tag.id)
  end

  def generate_tag_option(tag)
    "<option id='#{tag.id}'>#{tag.name}</option>"
  end

  def admin?(lesson, user)
    user && (lesson.admin == user)
  end

  def lesson_has_a_specific_location?(lesson)
    lesson.specific_location != nil && lesson.specific_location != ""
  end

  def lesson_has_a_specific_time?(lesson)
    lesson.specific_time != nil && lesson.specific_time != ""
  end

  def display_location(lesson) 
    if lesson_has_a_specific_location?(lesson)
      lesson.specific_location
    else
      "TBD"
    end
  end

  def adjusted_time(lesson)
    lesson.specific_time + 4.hours
  end

  def display_time(lesson) 
    if lesson_has_a_specific_time?(lesson)
      lesson.specific_time.to_formatted_s(:long_ordinal)
    else
      "TBD"
    end
  end

  def prepopulate_time(lesson)
    if lesson_has_a_specific_time?(lesson)
      return lesson.specific_time.to_formatted_s(:long_ordinal)
    else
      return ""
    end
  end

  def display_google_calendar_link(lesson)
    if lesson_has_a_specific_time?(lesson) && lesson_has_a_specific_location?(lesson)
      event_title = lesson.title.gsub(" ", "+")
      start_date = lesson.specific_time.iso8601.gsub("-", "").gsub(":", "").split("+")[0]
      start_date = start_date[0..-5]

      end_date = (lesson.specific_time + 2.hours).to_datetime.iso8601.gsub("-", "").gsub(":", "").split("+")[0]
      end_date = end_date[0..-5]      

      dates = "#{start_date}/#{end_date}"
      details = lesson.description.gsub(" ", "+")
      location = lesson.specific_location.gsub(" ", "+")

      href = "https://www.google.com/calendar/render?action=TEMPLATE&text=#{event_title}&dates=#{dates}&details=#{details}&location=#{location}&sf=true&output=xml"

      html = "<p><a href='#{href}' target='_blank' rel='nofollow'><span class='glyphicon glyphicon-calendar'></span> Add this lesson to my Google calendar</a></p>".html_safe
      return html
    else
      return ""
    end
  end

  def short_description(lesson)
    n = 25
    dek = lesson.description

    if dek.split.size > n
      "#{dek.split[0...n].join(' ')}..."
    else
      dek
    end
  end 

  def uri?(string)
    uri = URI.parse(string)
    %w( http https ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end

  def linkify_references(lesson)
    refs = lesson.references 

    refs_array = refs.split(
        /\s*[,;]\s* # comma or semicolon, optionally surrounded by whitespace
        |           # or
        \s{2,}      # two or more whitespace characters
        |           # or
        [\r\n]+     # any number of newline characters
        /x)

    refs_list_array = refs_array.map do |ref|
      if uri?(ref) 
        ref = "<li><a href='#{ref}' target='_blank'>#{ref}</a></li>"
      else
        ref = "<li>#{ref}</li>"
      end
    end

    refs_list = refs_list_array.join.html_safe
  end

end
