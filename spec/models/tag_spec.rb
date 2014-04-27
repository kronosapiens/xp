require 'spec_helper'

describe "Tag" do
  let(:lesson1){ create(:lesson) }
  let(:lesson2){ create(:lesson) }
  let(:lesson3){ create(:lesson, :closed) }
  let(:lesson4){ create(:lesson, :completed) }

  let(:topic_tag1){ create(:tag) }
  let(:topic_tag2){ create(:tag) }
  let(:topic_tag3){ create(:tag) }
  let(:topic_tag4){ create(:tag) }
  let(:location_tag1){ create(:tag, :location) }
  let(:location_tag2){ create(:tag, :location) }

  let(:user1){ create(:user) }
  let(:user2){ create(:user) }
  let(:user3){ create(:user) }
  let(:user4){ create(:user) }

  before(:each) do
    topic_tag1.lesson_tags.create(:lesson => lesson1)
    topic_tag1.lesson_tags.create(:lesson => lesson2)
    topic_tag1.lesson_tags.create(:lesson => lesson3)
    topic_tag1.lesson_tags.create(:lesson => lesson4)
    topic_tag2.lesson_tags.create(:lesson => lesson2)
    topic_tag3.lesson_tags.create(:lesson => lesson4)

    location_tag1.lesson_tags.create(:lesson => lesson1)
    location_tag2.lesson_tags.create(:lesson => lesson2)

    lesson1.registrations.create(:user => user1, :role => "teacher")
    lesson1.registrations.create(:user => user2, :role => "student")
    lesson2.registrations.create(:user => user1, :role => "teacher")
    lesson2.registrations.create(:user => user3, :role => "teacher")
  end

  describe "::all_by_category" do
    it "can return all tags by category" do
      expect(Tag.all_by_category("location")).to include(location_tag1)
      expect(Tag.all_by_category("location").length).to eq(2)
      expect(Tag.all_by_category("location")).to be_a(ActiveRecord::Relation)
    end
  end

  describe "::all_by_user" do
    it "can return all of itself for a particular user" do
      expect(Tag.all_by_user(user1).length).to eq(3 + 4) # Lesson 1 + Lesson 2
    end
  end

  describe "::used" do
    it "can return tags that have been used in lessons" do
      expect(Tag.used).to include(topic_tag1)
      expect(Tag.used).to_not include(topic_tag4)
      expect(Tag.used.length).to eq(3 + 2 + 4) # topic + location + FactoryGirl
    end
  end

  describe "::active" do
    it "can return tags that have open lessons" do
      expect(Tag.active).to include(topic_tag1)
      expect(Tag.active).to_not include(topic_tag3)
      expect(Tag.active.length).to eq(2 + 2 + 2) # topic + location + FactoryGirl
    end
  end

  describe "composite behavior:" do
    it "can chain class methods" do
      expect(Tag.all_by_category("topic").active).to include(topic_tag1)
      expect(Tag.all_by_category("topic").active.length).to eq(4)
    end
  end

  describe "#lessons" do
    it "can have topic_tag1_lesson as a lesson" do
      expect(topic_tag1.lessons).to include(lesson1)
    end

    it "doesn't include what it isn't tagged with" do
      expect(topic_tag2.lessons).to include(lesson2)
      expect(topic_tag2.lessons).to_not include(lesson1)
    end
  end

  describe "#slug" do
    it "automatically writes the slug before save" do
      expect(location_tag1.slug).to eq(location_tag1.name.downcase.gsub(" ", "-"))
    end
  end

  describe "#upcoming_lessons" do
    it "can find all of its upcoming lessons" do
      expect(topic_tag1.upcoming_lessons).to include(lesson2)
      expect(topic_tag1.upcoming_lessons).to include(lesson3)
      expect(topic_tag1.upcoming_lessons.length).to eq(3)
    end
  end

  describe "#completed_lessons" do
    it "can find all of its completed lessons" do
      expect(topic_tag1.completed_lessons).to include(lesson4)
      expect(topic_tag1.completed_lessons.length).to eq(1)
    end
  end

end
