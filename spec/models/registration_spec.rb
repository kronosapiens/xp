require 'spec_helper'

describe "Registration" do

  before(:each) do
    @css_lesson = Lesson.create(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @jquery_lesson = Lesson.create(:title => "Jquery Lesson", :description => "A lesson to talk about writing some great frontend", :references => "Bing it")

    @sam = User.create(:name => "Sam")
    @tom = User.create(:name => "Tom")
    @jack = User.create(:name => "Jack")

    @css_lesson.registrations.create(:user_id => @sam.id, :role => "student", :admin => true)
    @css_lesson.registrations.create(:user_id => @tom.id, :role => "teacher", :admin => false)
  end

  it "allows only one admin per lesson" do
    expect(@css_lesson.registrations.where(:admin => true).length).to eq(1)
    @css_lesson.registrations.create(:user_id => @jack.id, :role => "teacher", :admin => true)
    expect(@css_lesson.registrations.where(:admin => true).length).to eq(1)
    expect(@css_lesson.admin).to eq(@sam)
  end


end