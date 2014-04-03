require 'spec_helper'

describe "Tag" do

  before(:each) do
    @css_lesson = Lesson.new(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @jquery_lesson = Lesson.new(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")
    
    @css = Tag.create(:name => "CSS", :category => "topic")
    @jquery = Tag.create(:name => "jQuery", :category => "topic")

    @evening = Tag.create(:name => "Evening", :category => "time")
    @afternoon = Tag.create(:name => "Afternoon", :category => "time")

    @on_campus = Tag.create(:name => "On Campus", :category => "location")
    @remote = Tag.create(:name => "Remote", :category => "location")

    @css_lesson.lesson_tags.build(:tag => @css)
    @jquery_lesson.lesson_tags.build(:tag => @jquery)

    @css_lesson.lesson_tags.build(:tag => @afternoon)
    @jquery_lesson.lesson_tags.build(:tag => @evening)

    @css_lesson.lesson_tags.build(:tag => @remote)
    @jquery_lesson.lesson_tags.build(:tag => @on_campus)

    @css_lesson.save
    @jquery_lesson.save
  end

  it "can have css_lesson as a lesson" do
    expect(@css.lessons).to include(@css_lesson)
  end

  it "doesn't include what it isn't tagged with" do
    expect(@jquery.lessons).to include(@jquery_lesson)
    expect(@jquery.lessons).to_not include(@css_lesson)
  end

  it "can return only the topic tags" do
    expect(Tag.all_topics).to include(@jquery)
    expect(Tag.all_topics.length).to eq(2)
  end

  it "can return only the times tags" do
    expect(Tag.all_times).to include(@afternoon)
    expect(Tag.all_times.length).to eq(2)
  end

  it "can return only the location tags" do
    expect(Tag.all_locations).to include(@on_campus)
    expect(Tag.all_locations.length).to eq(2)
    expect(Tag.all_locations).to be_a(ActiveRecord::Relation)
  end

end













