require 'spec_helper'

describe LessonsHelper do
  let(:tag1){ create(:tag) }
  let(:tag2){ create(:tag) }
  let(:user){ create(:user) }
  let(:lesson){ create(:lesson) }

  before(:each) do
    lesson.tags << tag1
  end

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
