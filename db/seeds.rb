# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Creating some lessons
@css_lesson = Lesson.new(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
@jquery_lesson = Lesson.new(:title => "jQuery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")
@javascript_lesson = Lesson.new(:title => "Javascript Lesson", :description => "A lesson to talk about writing some great scripts", :references => "Ask Jeeves")
@sql_lesson = Lesson.new(:title => "SQL Lesson", :description => "Need help with SQL!", :references => "Yahoo Search")

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
@css_lesson.lesson_tags.build(:tag => @css)
@css_lesson.lesson_tags.build(:tag => @frontend)
@jquery_lesson.lesson_tags.build(:tag => @frontend)
@javascript_lesson.lesson_tags.build(:tag => @frontend)
@jquery_lesson.lesson_tags.build(:tag => @jquery)
@sql_lesson.lesson_tags.build(:tag => @sql)

@sql_lesson.lesson_tags.build(:tag => @evening)
@javascript_lesson.lesson_tags.build(:tag => @evening)
@jquery_lesson.lesson_tags.build(:tag => @evening)
@sql_lesson.lesson_tags.build(:tag => @afternoon)
@javascript_lesson.lesson_tags.build(:tag => @afternoon)
@css_lesson.lesson_tags.build(:tag => @afternoon)

@sql_lesson.lesson_tags.build(:tag => @on_campus)
@javascript_lesson.lesson_tags.build(:tag => @on_campus)
@css_lesson.lesson_tags.build(:tag => @on_campus)
@jquery_lesson.lesson_tags.build(:tag => @remote)
@javascript_lesson.lesson_tags.build(:tag => @remote)
@css_lesson.lesson_tags.build(:tag => @remote)

@css_lesson.save
@jquery_lesson.save
@javascript_lesson.save
@sql_lesson.save

#Creating some users
@sam = User.create(:name => "Sam", :uid => "12345", :nickname => "sts10", :image_url => "http://cdn.bulbagarden.net/upload/thumb/e/e2/133Eevee.png/250px-133Eevee.png")
@daniel = User.create(:name => "Daniel", :uid => "98765", :nickname => "kronosapiens", :image_url => "http://fc01.deviantart.net/fs70/f/2013/061/1/e/pikachu_digital_art___pokemon_by_dark_omni-d5wotdb.png")
@john = User.create(:name => "John", :uid => "14894", :nickname => "krauss", :image_url => "http://images1.wikia.nocookie.net/__cb20120906010245/es.pokemon/images/8/8b/Dratini_(anime_SO)_2.png")

#Associating some lessons and users
@css_lesson.registrations.create(:user => @sam, :role => "student", :admin => true)
@css_lesson.registrations.create(:user => @john, :role => "student")
@css_lesson.registrations.create(:user => @daniel, :role => "teacher")
@jquery_lesson.registrations.create(:user => @sam, :role => "teacher", :admin => true)
@jquery_lesson.registrations.create(:user => @daniel, :role => "student")
@sql_lesson.registrations.create(:user => @sam, :role => "student")
@sql_lesson.registrations.create(:user => @john, :role => "student", :admin => true)


# Creating some comments
@comment1 = Comment.create(:user_id => @sam.id, :lesson_id => @css_lesson.id, :content => "Comment from seed file from Sam to CSS Lesson")
@comment2 = Comment.create(:user_id => @daniel.id, :lesson_id => @css_lesson.id, :content => "Comment from seed file from Daniel to CSS Lesson")
@comment3 = Comment.create(:user_id => @john.id, :lesson_id => @css_lesson.id, :content => "Comment from seed file from John to CSS Lesson")
 