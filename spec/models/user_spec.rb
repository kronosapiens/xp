require 'spec_helper'

describe "User" do

  before(:each) do
    @css_lesson = Lesson.new(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @jquery_lesson = Lesson.new(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it", :status => "completed")
    @rails_lesson = Lesson.new(:title => "Rails Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it", :status => "closed")
    @arel_lesson = Lesson.new(:title => "Arel Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
  
    @css = Tag.create(:name => "CSS", :category => "topic")
    @jquery = Tag.create(:name => "jQuery", :category => "topic")
    @rails = Tag.create(:name => "Rails", :category => "topic")
    @arel = Tag.create(:name => "Arel", :category => "topic")
  
    @css_lesson.lesson_tags.build(:tag => @css)
    @jquery_lesson.lesson_tags.build(:tag => @jquery)
    @rails_lesson.lesson_tags.build(:tag => @rails)
    @arel_lesson.lesson_tags.build(:tag => @arel)

    @css_lesson.save
    @jquery_lesson.save
    @rails_lesson.save
    @arel_lesson.save
  
    @tom = User.create(:name => "Tom")
    @sam = User.create(:name => "Sam")
   
    @css_lesson.registrations.create(:user => @tom, :role => "teacher")

    @css_lesson.registrations.create(:user => @sam, :role => "student")
    @jquery_lesson.registrations.create(:user => @sam, :role => "teacher")
    @rails_lesson.registrations.create(:user => @sam, :role => "student")
    @arel_lesson.registrations.create(:user => @sam, :role => "teacher")
  end

  it 'knows what lessons it has' do
    expect(@sam.lessons.first).to eq(@css_lesson)
    expect(@sam.lessons.length).to eq(4)
  end

  it 'knows when it is a student' do
    expect(@sam.lessons_as_student.first).to eq(@css_lesson) 
  end

  it 'knows when it is a teacher' do
    expect(@tom.lessons_as_teacher.first).to eq(@css_lesson)
  end

  it 'can be both a student and a teacher' do
    @jquery_lesson.registrations.create(:user_id => @tom.id, :role => "teacher")
    expect(@tom.lessons_as_teacher).to include(@jquery_lesson)
    expect(@tom.lessons_as_teacher.length).to eq(2)
  end

  it 'can create a user from oauth' do
    auth_hash = {
     "provider"=>"github",
     "uid"=>"1874062",
     "info"=>
     {"nickname"=>"kronosapiens",
       "email"=>"kronovet@gmail.com",
       "name"=>"Daniel Kronovet",
       "image"=>"https://avatars.githubusercontent.com/u/1874062?"}
     }
    user = User.create_by_oauth(auth_hash)
    expect(user.uid).to eq("1874062")
    expect(user.email).to eq("kronovet@gmail.com")
  end

  it 'can find a user from oauth' do
    auth_hash = {
     "provider"=>"github",
     "uid"=>"1874062",
     "info"=>
     {"nickname"=>"kronosapiens",
       "email"=>"kronovet@gmail.com",
       "name"=>"Daniel Kronovet",
       "image"=>"https://avatars.githubusercontent.com/u/1874062?"}
     }
    user = User.create_by_oauth(auth_hash)
    expect(User.find_or_create_by_oauth(auth_hash)).to eq(user)
  end

  it 'knows its open lessons as a student' do 
    desired_lessons = @sam.lessons_by_role_and_status("student", "open")

    expect(desired_lessons).to include(@css_lesson)
    expect(desired_lessons).to_not include(@arel_lesson) 
  end

  it 'knows its upcoming lessons as a student' do 
    desired_lessons = (@sam.lessons_by_role_and_status("student", "open") + @sam.lessons_by_role_and_status("student", "closed"))

    expect(desired_lessons).to include(@css_lesson)
    expect(desired_lessons).to_not include(@arel_lesson) 
  end

  it 'knows its upcoming lessons as a teacher' do 
    desired_lessons = (@sam.lessons_by_role_and_status("teacher", "open")) # + @sam.lessons_by_role_and_status("student", "closed"))

    expect(desired_lessons).to include(@arel_lesson)
    expect(desired_lessons).to_not include(@css_lesson) 
  end

  it 'knows its completed lessons as a teacher' do 
    desired_lessons = (@sam.lessons_by_role_and_status("teacher", "completed"))

    expect(desired_lessons).to include(@jquery_lesson)
    expect(desired_lessons).to_not include(@arel_lesson) 
  end

end











