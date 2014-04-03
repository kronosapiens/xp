# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Creating some lessons
@css_lesson = Lesson.create(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
@jquery_lesson = Lesson.create(:title => "jQuery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")
@javascript_lesson = Lesson.create(:title => "Javascript Lesson", :description => "A lesson to talk about writing some great scripts", :references => "Ask Jeeves")
@sql_lesson = Lesson.create(:title => "SQL Lesson", :description => "Need help with SQL!", :references => "Yahoo Search")

#Creating some users
@sam = User.create(:name => "Sam")
@daniel = User.create(:name => "Daniel")
@john = User.create(:name => "John")

#Associating some lessons and users
@css_lesson.registrations.create(:user_id => @sam.id, :role => "student")
@css_lesson.registrations.create(:user_id => @john.id, :role => "student")
@css_lesson.registrations.create(:user_id => @daniel.id, :role => "teacher")
@jquery_lesson.registrations.create(:user_id => @sam.id, :role => "teacher")
@jquery_lesson.registrations.create(:user_id => @daniel.id, :role => "student")
@sql_lesson.registrations.create(:user_id => @sam.id, :role => "student")
@sql_lesson.registrations.create(:user_id => @john.id, :role => "student")

#Creating some tags
@css = Tag.create(:name => "CSS", :category => "topic")
@frontend = Tag.create(:name => "Front End", :category => "topic")
@jquery = Tag.create(:name => "jQuery", :category => "topic")
@javascript = Tag.create(:name => "JavaScript", :category => "topic")
@sql = Tag.create(:name => "SQL", :category => "topic")

@evening = Tag.create(:name => "Evening", :category => "time")
@afternoon = Tag.create(:name => "Afternoon", :category => "time")

@on_campus = Tag.create(:name => "On Campus", :category => "location")
@remote = Tag.create(:name => "Remote", :category => "location")

#Associating some lessons and tags
@css.lesson_tags.create(:lesson_id => @css_lesson.id)
@frontend.lesson_tags.create(:lesson_id => @css_lesson.id)
@frontend.lesson_tags.create(:lesson_id => @jquery_lesson.id)
@frontend.lesson_tags.create(:lesson_id => @javascript_lesson.id)
@jquery.lesson_tags.create(:lesson_id => @jquery_lesson.id)
@sql.lesson_tags.create(:lesson_id => @sql_lesson.id)

@evening.lesson_tags.create(:lesson_id => @sql_lesson.id)
@evening.lesson_tags.create(:lesson_id => @javascript_lesson.id)
@evening.lesson_tags.create(:lesson_id => @jquery_lesson.id)
@afternoon.lesson_tags.create(:lesson_id => @sql_lesson.id)
@afternoon.lesson_tags.create(:lesson_id => @javascript_lesson.id)
@afternoon.lesson_tags.create(:lesson_id => @css_lesson.id)

@on_campus.lesson_tags.create(:lesson_id => @sql_lesson.id)
@on_campus.lesson_tags.create(:lesson_id => @javascript_lesson.id)
@on_campus.lesson_tags.create(:lesson_id => @css_lesson.id)
@remote.lesson_tags.create(:lesson_id => @jquery_lesson.id)
@remote.lesson_tags.create(:lesson_id => @javascript_lesson.id)
@remote.lesson_tags.create(:lesson_id => @css_lesson.id)





