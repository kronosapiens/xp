require 'spec_helper'

describe "Tag" do

  before(:each) do
    @lesson1 = create(:lesson)
    @lesson2 = create(:lesson)
    @lesson3 = create(:lesson)
    @lesson4 = create(:lesson)

    @lesson3.update(:status => "closed")
    @lesson4.update(:status => "completed")

    @topic_tag1 = create(:tag)
    @topic_tag2 = create(:tag)

    @location_tag1 = create(:tag)
    @location_tag1.update(:category => "location")
    @location_tag2 = create(:tag)
    @location_tag2.update(:category => "location")

    @topic_tag1.lesson_tags.create(:lesson => @lesson1)
    @topic_tag1.lesson_tags.create(:lesson => @lesson2)
    @topic_tag1.lesson_tags.create(:lesson => @lesson3)
    @topic_tag1.lesson_tags.create(:lesson => @lesson4)
    @topic_tag2.lesson_tags.create(:lesson => @lesson2)

    @location_tag1.lesson_tags.create(:lesson => @lesson1)
    @location_tag2.lesson_tags.create(:lesson => @lesson2)

    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)

    @lesson1.registrations.create(:user => @user1, :role => "teacher")
    @lesson1.registrations.create(:user => @user2, :role => "student")
    @lesson2.registrations.create(:user => @user1, :role => "teacher")
    @lesson2.registrations.create(:user => @user3, :role => "teacher")
  end

  it "can have topic_tag1_lesson as a lesson" do
    expect(@topic_tag1.lessons).to include(@lesson1)
  end

  it "doesn't include what it isn't tagged with" do
    expect(@topic_tag2.lessons).to include(@lesson2)
    expect(@topic_tag2.lessons).to_not include(@lesson1)
  end

  it "can return only the topic tags" do
    expect(Tag.all_by_category("topic")).to include(@topic_tag2)
    expect(Tag.all_by_category("topic").length).to eq(6)
  end

  it "can return all tags by category" do
    expect(Tag.all_by_category("location")).to include(@location_tag1)
    expect(Tag.all_by_category("location").length).to eq(2)
    expect(Tag.all_by_category("location")).to be_a(ActiveRecord::Relation)
  end

  it "automatically writes the slug before save" do
    expect(@location_tag1.slug).to eq(@location_tag1.name.downcase.gsub(" ", "-"))
  end

  it "can find all of its upcoming lessons" do
    expect(@topic_tag1.upcoming_lessons).to include(@lesson2)
    expect(@topic_tag1.upcoming_lessons).to include(@lesson3)
    expect(@topic_tag1.upcoming_lessons.length).to eq(3)
  end

  it "can find all of its completed lessons" do
    expect(@topic_tag1.completed_lessons).to include(@lesson4)
    expect(@topic_tag1.completed_lessons.length).to eq(1)
  end

  it "can return all of itself for a particular user" do
    expect(Tag.all_by_user(@topic_tag1, @user1).length).to eq(2)
  end

end
