# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#Creating some tags
@frontend = Tag.create(:name => "Front-End", :category => "topic")
@rails = Tag.create(:name => "Rails", :category => "topic")
@testing = Tag.create(:name => "Testing", :category => "topic")
@databases = Tag.create(:name => "Databases", :category => "topic")
@random_fun = Tag.create(:name => "Random Fun", :category => "topic")
@rubygems = Tag.create(:name => "Ruby Gems", :category => "topic")
@deployment = Tag.create(:name => "Deployment", :category => "topic")
@console = Tag.create(:name => "Console", :category => "topic")
@soft_skills = Tag.create(:name => "Soft Skills", :category => "topic")

@ruby = Tag.create(:name => "Ruby", :category => "language")
@javascript = Tag.create(:name => "JavaScript", :category => "language")
@css = Tag.create(:name => "CSS", :category => "language")
@sql = Tag.create(:name => "SQL", :category => "language")
@objective_c = Tag.create(:name => "Objective-C", :category => "language")
@python = Tag.create(:name => "Python", :category => "language")
@php = Tag.create(:name => "PHP", :category => "language")

@morning = Tag.create(:name => "Morning", :category => "time")
@afternoon = Tag.create(:name => "Afternoon", :category => "time")
@evening = Tag.create(:name => "Evening", :category => "time")
@monday = Tag.create(:name => "Monday", :category => "time")
@tuesday = Tag.create(:name => "Tuesday", :category => "time")
@wednesday = Tag.create(:name => "Wednesday", :category => "time")
@thursday = Tag.create(:name => "Thursday", :category => "time")
@friday = Tag.create(:name => "Friday", :category => "time")
@saturday = Tag.create(:name => "Saturday", :category => "time")
@sunday = Tag.create(:name => "Sunday", :category => "time")

@flatiron_mnh = Tag.create(:name => "Flatiron (Manhattan)", :category => "location")
@flatiron_bk = Tag.create(:name => "Flatiron (Brooklyn)", :category => "location")
@manhattan = Tag.create(:name => "Manhattan", :category => "location")
@brooklyn = Tag.create(:name => "Brooklyn", :category => "location")
@queens = Tag.create(:name => "Queens", :category => "location")
@bronx = Tag.create(:name => "The Bronx", :category => "location")
@staten = Tag.create(:name => "Staten Island", :category => "location")
@virtual = Tag.create(:name => "Virtual", :category => "location")

# Creating some lessons
@css_lesson = Lesson.new(:title => "CSS Lesson", :description => "Can someone help me understand the CSS prework?", :references => "http://www.skillshare.com/Build-a-HTML-and-CSS-Website-From-Scratch/1216366887")
@jquery_lesson = Lesson.new(:title => "jQuery Lesson", :description => "I can help a few people work through some jQuery problems.", :references => "http://learn.jquery.com/about-jquery/how-jquery-works/")
@javascript_lesson = Lesson.new(:title => "Javascript Lesson", :description => "A lesson to talk about writing some great scripts", :references => "https://github.com/dhh/popcorn_js-ruby-004")
@sql_lesson = Lesson.new(:title => "SQL Lesson", :description => "Need help with SQL!", :references => "http://teamtreehouse.com/library/programming/database-foundations")

#Associating some lessons and tags
@css_lesson.tags << @css
@css_lesson.tags << @frontend
@jquery_lesson.tags << @frontend
@javascript_lesson.tags << @frontend
@javascript_lesson.tags << @javascript
@jquery_lesson.tags << @frontend
@sql_lesson.tags << @sql
@sql_lesson.tags << @databases

@sql_lesson.tags << @evening
@javascript_lesson.tags << @evening
@jquery_lesson.tags << @evening
@sql_lesson.tags << @afternoon
@javascript_lesson.tags << @afternoon
@css_lesson.tags << @afternoon

@sql_lesson.tags << @flatiron_mnh
@javascript_lesson.tags << @flatiron_mnh
@css_lesson.tags << @flatiron_mnh
@jquery_lesson.tags << @manhattan
@javascript_lesson.tags << @brooklyn
@css_lesson.tags << @virtual

@css_lesson.save
@jquery_lesson.save
@javascript_lesson.save
@sql_lesson.save

#Creating some users
@eevee = User.create(:name => "Eevee", :uid => "12345", :nickname => "e3ve3", :image_url => "http://cdn.bulbagarden.net/upload/thumb/e/e2/133Eevee.png/250px-133Eevee.png")
@pikachu = User.create(:name => "Pikachu", :uid => "98765", :nickname => "pikapika", :image_url => "http://fc01.deviantart.net/fs70/f/2013/061/1/e/pikachu_digital_art___pokemon_by_dark_omni-d5wotdb.png")
@dratini = User.create(:name => "Dratini", :uid => "14894", :nickname => "dratinibobini", :image_url => "http://images1.wikia.nocookie.net/__cb20120906010245/es.pokemon/images/8/8b/Dratini_(anime_SO)_2.png")

#Associating some lessons and users
@css_lesson.registrations.create(:user => @eevee, :role => "student")
@css_lesson.registrations.create(:user => @dratini, :role => "student")
@css_lesson.registrations.create(:user => @pikachu, :role => "teacher")
@jquery_lesson.registrations.create(:user => @eevee, :role => "teacher", :admin => true)
@sql_lesson.registrations.create(:user => @eevee, :role => "student")
@sql_lesson.registrations.create(:user => @dratini, :role => "student", :admin => true)
@javascript_lesson.registrations.create(:user => @eevee, :role => "teacher")
@javascript_lesson.registrations.create(:user => @pikachu, :role => "student")

# Creating some comments
@comment1 = Comment.create(:user_id => @eevee.id, :lesson_id => @css_lesson.id, :content => "I'm really confused about block elements")
@comment2 = Comment.create(:user_id => @pikachu.id, :lesson_id => @css_lesson.id, :content => "I can help with that. When are you free?")
@comment3 = Comment.create(:user_id => @dratini.id, :lesson_id => @css_lesson.id, :content => "I can meet weekends -- I'm usually around Flatiron anyway")
@comment4 = Comment.create(:user_id => @pikachu.id, :lesson_id => @javascript_lesson.id, :content => "Would Sunday afternoon work for people? I'm free to meet anywhere.")
@comment5 = Comment.create(:user_id => @eevee.id, :lesson_id => @javascript_lesson.id, :content => "I'd be interested in this if I were available, but I can't commit yet.")

 