require 'spec_helper'

describe "Lesson" do

  before(:each) do
    @css_lesson = Lesson.new(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @jquery_lesson = Lesson.new(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")
    @ruby_lesson = Lesson.new(:title => "Ruby Lesson", :description => "A lesson to talk about writing some great ruby", :references => "Bing it")
    @html_lesson = Lesson.new(:title => "HTML Lesson", :description => "A lesson to talk about writing some great HTML", :references => "Bing it")

    @css = Tag.create(:name => "CSS", :category => "topic")
    @jquery = Tag.create(:name => "jQuery", :category => "topic")
    @frontend = Tag.create(:name => "Front End", :category => "topic")

    @on_campus = Tag.create(:name => "On Campus", :category => "location")
    @evening = Tag.create(:name => "Evening", :category => "time")

    @css_lesson.lesson_tags.build(:tag => @css)
    @jquery_lesson.lesson_tags.build(:tag => @jquery)
    @jquery_lesson.lesson_tags.build(:tag => @frontend)
    @jquery_lesson.lesson_tags.build(:tag => @on_campus)
    @html_lesson.lesson_tags.build(:tag => @on_campus)

    @css_lesson.save
    @jquery_lesson.save
    @ruby_lesson.save
    @html_lesson.save

    @steve = User.create(:name => "Steve")
    @sam = User.create(:name => "Sam")
    @tom = User.create(:name => "Tom")
    @ted = User.create(:name => "Ted")
    @jack = User.create(:name => "Jack")

    @css_lesson.registrations.create(:user => @sam, :role => "student", :admin => true)
    @css_lesson.registrations.create(:user => @steve, :role => "student")
    @css_lesson.registrations.create(:user => @tom, :role => "teacher", :admin => false)
    @css_lesson.registrations.create(:user => @ted, :role => "teacher")
    @html_lesson.registrations.create(:user => @ted, :role => "student")
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

  it "can return tags of a particular category" do
    expect(@jquery_lesson.location_tags).to include(@on_campus)
    expect(@jquery_lesson.location_tags.length).to eq(1)
    expect(@jquery_lesson.topic_tags).to include(@frontend)
    expect(@jquery_lesson.topic_tags.length).to eq(2)
  end

  it "returns [] if it has no tags of a particular category" do
    (expect(@css_lesson.location_tags).to eq([]))
  end

  it "can have multiple tags" do
    expect(@jquery_lesson.tags.length).to eq(3)
  end

  it "can return its tags as a string" do
    expect(@jquery_lesson.tags_to_string).to be_a(String)
    expect(@jquery_lesson.tags_to_string).to eq("jQuery, Front End, On Campus")
  end

  it "can return its tag ids as an array" do
    expect(@jquery_lesson.tag_ids_to_array).to be_a(Array)
    expect(@jquery_lesson.tag_ids_to_array).to eq([2, 3, 4])
  end

  it "can add tags to itself, given a full hash of existing tags" do
    tags_hash = {
      :topics => ["CSS", "jQuery"],
      :locations => ["On Campus"],
      :times => ["Evening"]
    } 
    @ruby_lesson.build_tags(tags_hash)
    @ruby_lesson.save

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
    @ruby_lesson.save

    expect(@ruby_lesson.tags).to include(@jquery)
    expect(@ruby_lesson.tags).to include(@evening)
    expect(@ruby_lesson.tags).to_not include(@on_campus)
    expect(@ruby_lesson.tags.length).to eq(3)
  end

  it "knows its admin" do
    expect(@css_lesson.admin).to eq(@sam)
    expect(@css_lesson.admin).to_not eq(@tom)
  end

  it "it returns nil if theres no admin" do
    expect(@jquery_lesson.admin).to eq(nil)
  end

  it "verifies user count before deletion" do
    expect(@html_lesson.ok_to_delete?).to eq(false)
    expect(@css_lesson.ok_to_delete?).to eq(true)
  end

end