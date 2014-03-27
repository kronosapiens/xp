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

    @css = Tag.create(:name => "CSS")
    @jquery = Tag.create(:name => "jQuery")
    @frontend = Tag.create(:name => "Front End")

    @css.lesson_tags.create(:lesson_id => @css_lesson.id)
    @jquery.lesson_tags.create(:lesson_id => @jquery_lesson.id)
    @frontend.lesson_tags.create(:lesson_id => @jquery_lesson.id)
  end

  it "can have sam as a user" do
    expect(@css_lesson.users).to include(@sam)
  end

  it "can have tom as a user" do
    expect(@css_lesson.users).to include(@tom)
  end

  it "knows its students" do 
    expect(@css_lesson.students).to include(@sam)
    expect(@css_lesson.students).to include(@steve)
    expect(@css_lesson.students.length).to eq(2)
  end

  it "knows its teachers" do
    expect(@css_lesson.teachers).to include(@tom)
    expect(@css_lesson.teachers).to include(@ted)
    expect(@css_lesson.teachers.length).to eq(2)
  end

  it "knows the first teacher" do
    expect(@css_lesson.first_teacher).to eq(@tom)
  end

  it "knows what tags it has" do
    expect(@css_lesson.tags).to include(@css)
    expect(@css_lesson.tags).to_not include(@jquery)
    expect(@css_lesson.tags.length).to eq(1)
  end

  it "can have multiple tags" do
    expect(@jquery_lesson.tags.length).to eq(2)
  end

  it "can return its tags as a string" do
    expect(@jquery_lesson.tags_to_string).to be_a(String)
    expect(@jquery_lesson.tags_to_string).to eq("jQuery, Front End")
  end

end