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


  def lesson_has_a_specific_location?(lesson)
    lesson.specific_location != nil && lesson.specific_location != ""
  end

  def lesson_has_a_specific_time?(lesson)
    lesson.specific_time != nil && lesson.specific_time != ""
  end

  def adjusted_time(lesson)
    lesson.specific_time - 4.hours
  end


  def display_location(lesson) 
    if lesson_has_a_specific_location?(lesson)
      lesson.specific_location
    else
      "TDB"
    end
  end

  def display_time(lesson) 
    if lesson_has_a_specific_time?(lesson)
      adjusted_time(lesson).to_formatted_s(:long_ordinal)
    else
      "TDB"
    end
  end

  def prepopulate_time(lesson)
    if lesson_has_a_specific_time?(lesson)
      return adjusted_time(lesson).to_formatted_s(:long_ordinal)
    else
      return ""
    end
  end


  def display_google_calendar_link(lesson)
    if lesson_has_a_specific_time?(lesson) && lesson_has_a_specific_location?(lesson)
      event_title = lesson.title.gsub(" ", "+")
      start_date = lesson.specific_time.iso8601.gsub("-", "").gsub(":", "").split("+")[0]
      end_date = (lesson.specific_time + 2.hours).to_datetime.iso8601.gsub("-", "").gsub(":", "").split("+")[0]
      dates = "#{start_date}/#{end_date}Z"
      details = lesson.description.gsub(" ", "+")
      location = lesson.specific_location.gsub(" ", "+")

      href = "https://www.google.com/calendar/render?action=TEMPLATE&text=#{event_title}&dates=#{dates}&details=#{details}&location=#{location}&sf=true&output=xml"

      html = "<p><a href='#{href}' target='_blank' rel='nofollow'>Add this lesson to my Google calendar</a></p>".html_safe
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
    # binding.pry
    refs = lesson.references 

    refs_array = refs.split(
        /\s*[,;]\s* # comma or semicolon, optionally surrounded by whitespace
        |           # or
        \s{2,}      # two or more whitespace characters
        |           # or
        [\r\n]+     # any number of newline characters
        /x)

    refs_list_array = refs_array.map do |ref|
      if uri?(ref) # if ref.include?("http")
        ref = "<li><a href='#{ref}'>#{ref}</a></li>"
      else
        ref = "<li>#{ref}</li>"
      end
    end

    refs_list = refs_list_array.join.html_safe
  end

  def one_user?(lesson)
    lesson.registrations.length == 1
  end

end
