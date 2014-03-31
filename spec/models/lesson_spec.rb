require 'spec_helper'

describe "Lesson" do

  before(:each) do
    @css_lesson = Lesson.create(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @jquery_lesson = Lesson.create(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")
    @ruby_lesson = Lesson.create(:title => "Ruby Lesson", :description => "A lesson to talk about writing some great ruby", :references => "Bing it")


    @steve = User.create(:name => "Steve")
    @sam = User.create(:name => "Sam")
    @tom = User.create(:name => "Tom")
    @ted = User.create(:name => "Ted")

    @css_lesson.user_lessons.create(:user_id => @sam.id, :role => "student")
    @css_lesson.user_lessons.create(:user_id => @steve.id, :role => "student")
    @css_lesson.user_lessons.create(:user_id => @tom.id, :role => "teacher")
    @css_lesson.user_lessons.create(:user_id => @ted.id, :role => "teacher")

    @css = Tag.create(:name => "CSS", :category => "topic")
    @jquery = Tag.create(:name => "jQuery", :category => "topic")
    @frontend = Tag.create(:name => "Front End", :category => "topic")

    @on_campus = Tag.create(:name => "On Campus", :category => "location")
    @evening = Tag.create(:name => "Evening", :category => "time")

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

  it "returns [] if it has no students" do
    expect(@ruby_lesson.students).to eq([])
  end

  it "returns [] if it has no teachers" do
    expect(@ruby_lesson.teachers).to eq([])
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

  it "can return its tag ids as an array" do
    expect(@jquery_lesson.tag_ids_to_array).to be_a(Array)
    expect(@jquery_lesson.tag_ids_to_array).to eq([2, 3])
  end

  it "can add tags to itself, given a full hash of existing tags" do
    tags_hash = {
      :topics => ["CSS", "jQuery"],
      :locations => ["On Campus"],
      :times => ["Evening"]
    } 
    @ruby_lesson.build_tags(tags_hash)

    expect(@ruby_lesson.tags).to include(@css)
    expect(@ruby_lesson.tags).to include(@on_campus)
    expect(@ruby_lesson.tags).to include(@evening)
    expect(@ruby_lesson.tags.length).to eq(4)
  end

  it "can add tags to itself, given a partial hash of existing tags" do
        tags_hash = {
      :topics => ["CSS", "jQuery"],
      :locations => nil,
      :times => ["Evening"]
    } 
    @ruby_lesson.build_tags(tags_hash)

    expect(@ruby_lesson.tags).to include(@jquery)
    expect(@ruby_lesson.tags).to include(@evening)
    expect(@ruby_lesson.tags).to_not include(@on_campus)
    expect(@ruby_lesson.tags.length).to eq(3)
  end

end