# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Creating some lessons
@css_lesson = Lesson.new(:title => "CSS Lesson", :description => "Can someone help me understand the CSS prework?", :references => "http://www.skillshare.com/Build-a-HTML-and-CSS-Website-From-Scratch/1216366887")
@jquery_lesson = Lesson.new(:title => "jQuery Lesson", :description => "I can help a few people work through some jQuery problems.", :references => "http://learn.jquery.com/about-jquery/how-jquery-works/")
@javascript_lesson = Lesson.new(:title => "Javascript Lesson", :description => "A lesson to talk about writing some great scripts", :references => "https://github.com/dhh/popcorn_js-ruby-004")
@sql_lesson = Lesson.new(:title => "SQL Lesson", :description => "Need help with SQL!", :references => "http://teamtreehouse.com/library/programming/database-foundations")

#Creating some tags
@css = Tag.create(:name => "CSS", :category => "topic")
@frontend = Tag.create(:name => "Front End", :category => "topic")
@backend = Tag.create(:name => "Back End", :category => "topic")
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
@javascript_lesson.lesson_tags.build(:tag => @javascript)
@jquery_lesson.lesson_tags.build(:tag => @jquery)
@sql_lesson.lesson_tags.build(:tag => @sql)
@sql_lesson.lesson_tags.build(:tag => @backend)

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
@isaac = User.create(:name => "Isaac", :uid => "98765", :nickname => "izk.harper", :image_url => "http://fc01.deviantart.net/fs70/f/2013/061/1/e/pikachu_digital_art___pokemon_by_dark_omni-d5wotdb.png")
@john = User.create(:name => "John", :uid => "14894", :nickname => "krauss", :image_url => "http://images1.wikia.nocookie.net/__cb20120906010245/es.pokemon/images/8/8b/Dratini_(anime_SO)_2.png")

#Associating some lessons and users
@css_lesson.registrations.create(:user => @sam, :role => "student", :admin => true)
@css_lesson.registrations.create(:user => @john, :role => "student")
@css_lesson.registrations.create(:user => @isaac, :role => "teacher")
@jquery_lesson.registrations.create(:user => @sam, :role => "teacher", :admin => true)
@sql_lesson.registrations.create(:user => @sam, :role => "student")
@sql_lesson.registrations.create(:user => @john, :role => "student", :admin => true)
@javascript_lesson.registrations.create(:user => @sam, :role => "teacher")
@javascript_lesson.registrations.create(:user => @isaac, :role => "student")

# Creating some comments
@comment1 = Comment.create(:user_id => @sam.id, :lesson_id => @css_lesson.id, :content => "I'm really confused about block elements")
@comment2 = Comment.create(:user_id => @isaac.id, :lesson_id => @css_lesson.id, :content => "I can help with that. When are you free?")
@comment3 = Comment.create(:user_id => @john.id, :lesson_id => @css_lesson.id, :content => "I can meet weekends -- I'm usually around Flatiron anyway")
@comment4 = Comment.create(:user_id => @isaac.id, :lesson_id => @javascript_lesson.id, :content => "Would Sunday afternoon work for people? I'm free to meet anywhere.")
@comment5 = Comment.create(:user_id => @sam.id, :lesson_id => @javascript_lesson.id, :content => "I'd be interested in this if I were available, but I can't commit yet.")

 