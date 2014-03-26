require 'spec_helper'

describe "Tag" do

  before(:each) do
    @css = Tag.create(:name => "CSS")
    @jquery = Tag.create(:name => "jQuery")
    @css_lesson = Lesson.create(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @jquery_lesson = Lesson.create(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")

    @css.lesson_tags.create(:lesson_id => @css_lesson.id)
    @jquery.lesson_tags.create(:lesson_id => @jquery_lesson.id)
  end

  it "can have css_lesson as a lesson" do
    expect(@css.lessons).to include(@css_lesson)
  end

  it "doesn't include what it isn't tagged with" do
    expect(@jquery.lessons).to include(@jquery_lesson)
    expect(@jquery.lessons).to_not include(@css_lesson)
  end

end