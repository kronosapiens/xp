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

    let(:tag1){ create(:tag).tap { |tag| tag.update(:category => "topic") } }
    let(:tag2){ create(:tag).tap { |tag| tag.update(:category => "topic") } }
    let(:lesson){ create(:lesson).tap { |lesson| lesson.tags << tag1 } }
    let(:user){ create(:user) }

  it "returns 'selected' if it has the tag" do
    expect(prepopulate_tags(lesson, tag1)).to eq("selected")
  end

  it "returns nothing if it doesn't have the tag" do
    expect(prepopulate_tags(lesson, tag2)).to eq(nil)
  end
  
  it "knows when the lesson has only one user" do
    lesson.registrations.create(:user => user, :role => "student", :admin => true)
    expect(one_user?(lesson)).to eq(true)
  end


end
