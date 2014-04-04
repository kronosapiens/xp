require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the LessonsHelper. For example:
#
# describe LessonsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe LessonsHelper do

  before(:each) do
    @css_lesson = Lesson.new(:title => "Css Lesson", :description => "A lesson to talk about writing a stylesheet", :references => "Google it")
    @css = Tag.create(:name => "CSS", :category => "topic")
    @jquery = Tag.create(:name => "jQuery", :category => "topic")
    @css_lesson.lesson_tags.build(:tag => @css)
    @css_lesson.save

    @sam = User.create(:name => "Sam")
    @css_lesson.registrations.create(:user => @sam, :role => "student", :admin => true)
  end

  it "returns 'selected' if it has the tag" do
    expect(prepopulate(@css_lesson, @css)).to eq("selected")
  end

  it "returns nothing if it doesn't have the tag" do
    expect(prepopulate(@css_lesson, @jquery)).to eq(nil)
  end
  
  it "knows when the lesson has only one user" do
    expect(one_user?(@css_lesson)).to eq(true)
  end


end
