require 'spec_helper'

describe "Tag" do

  before(:each) do
    @lesson1 = create(:lesson)
    @lesson2 = create(:lesson)
    @lesson3 = create(:lesson)
    @lesson4 = create(:lesson)

    @lesson3.update(:status => "closed")
    @lesson4.update(:status => "completed")

    @css = Tag.create(:name => "CSS", :category => "topic")
    @jquery = Tag.create(:name => "jQuery", :category => "topic")

    @evening = Tag.create(:name => "Evening", :category => "time")
    @afternoon = Tag.create(:name => "Afternoon", :category => "time")

    @on_campus = Tag.create(:name => "On Campus", :category => "location")
    @remote = Tag.create(:name => "Remote", :category => "location")

    @css.lesson_tags.create(:lesson => @lesson1)
    @jquery.lesson_tags.create(:lesson => @lesson2)

    @evening.lesson_tags.create(:lesson => @lesson1)
    @afternoon.lesson_tags.create(:lesson => @lesson2)

    @on_campus.lesson_tags.create(:lesson => @lesson1)
    @remote.lesson_tags.create(:lesson => @lesson2)

    @css.lesson_tags.create(:lesson => @lesson2)
    @css.lesson_tags.create(:lesson => @lesson3)
    @css.lesson_tags.create(:lesson => @lesson4)

    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)

    @lesson1.registrations.build(:user => @user1, :role => "teacher")
    @lesson1.registrations.build(:user => @user2, :role => "student")
    @lesson2.registrations.build(:user => @user1, :role => "teacher")
    @lesson2.registrations.build(:user => @user3, :role => "teacher")
  end

  it "can have css_lesson as a lesson" do
    expect(@css.lessons).to include(@lesson1)
  end

  it "doesn't include what it isn't tagged with" do
    expect(@jquery.lessons).to include(@lesson2)
    expect(@jquery.lessons).to_not include(@lesson1)
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

  it "automatically writes the slug before save" do
    expect(@on_campus.slug).to eq("on-campus")
  end

  it "can find all of its upcoming lessons" do
    expect(@css.upcoming_lessons).to include(@lesson2)
    expect(@css.upcoming_lessons).to include(@lesson3)
    expect(@css.upcoming_lessons.length).to eq(3)
  end

  it "can find all of its completed lessons" do
    expect(@css.completed_lessons).to include(@lesson4)
    expect(@css.completed_lessons.length).to eq(1)
  end

end













