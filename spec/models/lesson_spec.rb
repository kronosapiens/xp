require 'spec_helper'

describe "Lesson" do

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

  it "can have sam as a user" do
    expect(@css_lesson.users).to include(@sam)
  end

  it "can have tom as a user" do
    expect(@css_lesson.users).to include(@tom)
  end

  it "knows it's students" do 
    expect(@css_lesson.students).to include(@sam)
    expect(@css_lesson.students).to include(@steve)
  end

  it "knows it's teachers" do
    expect(@css_lesson.teachers).to include(@tom)
    expect(@css_lesson.teachers).to include(@ted)
  end

end