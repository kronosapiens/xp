require 'spec_helper'

describe "Registration" do

  before(:each) do
    @css_lesson = Lesson.new(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @jquery_lesson = Lesson.new(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")

    @css = Tag.create(:name => "CSS", :category => "topic")
  
    @css_lesson.lesson_tags.build(:tag => @css)
    @jquery_lesson.lesson_tags.build(:tag => @jquery)

    @css_lesson.save
    @jquery_lesson.save

    @sam = User.create(:name => "Sam")
    @tom = User.create(:name => "Tom")
    @jack = User.create(:name => "Jack")

    @css_lesson.registrations.create(:user => @sam, :role => "student", :admin => true)
    @css_lesson.registrations.create(:user => @tom, :role => "teacher", :admin => false)
  end

  it "allows only one admin per lesson" do
    expect(@css_lesson.registrations.where(:admin => true).length).to eq(1)
    @css_lesson.registrations.create(:user_id => @jack.id, :role => "teacher", :admin => true)
    expect(@css_lesson.registrations.where(:admin => true).length).to eq(1)
    expect(@css_lesson.admin).to eq(@sam)
  end


end