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

#Creating some users
@sam = User.create(:name => "Sam")
@daniel = User.create(:name => "Daniel")
@john = User.create(:name => "John")

#Associating some lessons and users
@css_lesson.user_lessons.create(:user_id => @sam.id, :role => "student")
@css_lesson.user_lessons.create(:user_id => @john.id, :role => "student")
@css_lesson.user_lessons.create(:user_id => @daniel.id, :role => "teacher")
@jquery_lesson.user_lessons.create(:user_id => @sam.id, :role => "teacher")
@jquery_lesson.user_lessons.create(:user_id => @daniel.id, :role => "student")

#Creating some tags
@css = Tag.create(:name => "CSS")
@frontend = Tag.create(:name => "Front End")
@jquery = Tag.create(:name => "jQuery")
@javascript = Tag.create(:name => "JavaScript")

#Associating some lessons and tags
@css.lesson_tags.create(:lesson_id => @css_lesson.id)
@frontend.lesson_tags.create(:lesson_id => @css_lesson.id)
@frontend.lesson_tags.create(:lesson_id => @jquery_lesson.id)
@frontend.lesson_tags.create(:lesson_id => @javascript_lesson.id)
@jquery.lesson_tags.create(:lesson_id => @jquery_lesson.id)
@jquery.lesson_tags.create(:lesson_id => @javascript_lesson.id)


