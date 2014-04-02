require 'spec_helper'

describe "User" do

  before(:each) do
    @css_lesson = Lesson.create(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @jquery_lesson = Lesson.create(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")
    @steve = User.create(:name => "Steve")
    @sam = User.create(:name => "Sam")
    @tom = User.create(:name => "Tom")
    @ted = User.create(:name => "Ted")

    @css_lesson.user_lessons.create(:user_id => @sam.id, :role => "student")
    @css_lesson.user_lessons.create(:user_id => @steve.id, :role => "student")
    @css_lesson.user_lessons.create(:user_id => @tom.id, :role => "teacher")
    @css_lesson.user_lessons.create(:user_id => @ted.id, :role => "teacher")
  end

  it 'knows what lessons it has' do
    expect(@sam.lessons.first).to eq(@css_lesson)
    expect(@sam.lessons.length).to eq(1)
  end

  it 'knows when it is a student' do
    expect(@sam.lessons_as_student.first).to eq(@css_lesson) 
  end

  it 'knows when it is a teacher' do
    expect(@tom.lessons_as_teacher.first).to eq(@css_lesson)
  end

  it 'can be both a student and a teacher' do
    @jquery_lesson.user_lessons.create(:user_id => @sam.id, :role => "teacher")
    expect(@sam.lessons_as_teacher).to include(@jquery_lesson)
    expect(@sam.lessons_as_teacher.length).to eq(1)
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

end











