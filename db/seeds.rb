# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Creating some lessons
@css_lesson = Lesson.create(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
@jquery_lesson = Lesson.create(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")

#Creating some users
@steve = User.create(:name => "Steve")
@sam = User.create(:name => "Sam")
@tom = User.create(:name => "Tom")
@ted = User.create(:name => "Ted")

#Associating some lessons and users
@css_lesson.user_lessons.create(:user_id => @sam.id, :role => "student")
@css_lesson.user_lessons.create(:user_id => @steve.id, :role => "student")
@css_lesson.user_lessons.create(:user_id => @tom.id, :role => "teacher")
@css_lesson.user_lessons.create(:user_id => @ted.id, :role => "teacher")

#Creating some tags
@css = Tag.create(:name => "CSS")
@jquery = Tag.create(:name => "jQuery")

#Associating some lessons and tags
@css.lesson_tags.create(:lesson_id => @css_lesson.id)
@jquery.lesson_tags.create(:lesson_id => @jquery_lesson.id)


