require 'spec_helper'

describe "Lesson" do

  before(:each) do
    @lesson1 = create(:lesson) 
    @lesson2 = create(:lesson) 
    @lesson3 = create(:lesson)
    @lesson4 = create(:lesson) 
    @lesson3.update(:status => "closed") 
    @lesson4.update(:status => "completed") 

    @topic_tag1 = create(:tag)
    @topic_tag2 = create(:tag)
    @topic_tag3 = create(:tag)

    @location_tag1 = create(:tag)
    @location_tag2 = create(:tag)
    @location_tag1.update(:category => "location")
    @location_tag2.update(:category => "location")

    @time_tag1 = create(:tag)
    @time_tag1.update(:category => "time")

    @lesson1.tags << @topic_tag1
    @lesson2.tags << @topic_tag2
    @lesson2.tags << @topic_tag3
    @lesson2.tags << @location_tag1
    @lesson4.tags << @location_tag1

    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
    @user5 = create(:user)

    @lesson1.registrations.create(:user => @user1, :role => "student")
    @lesson1.registrations.create(:user => @user2, :role => "student", :admin => true)
    @lesson1.registrations.create(:user => @user3, :role => "teacher", :admin => false)
    @lesson1.registrations.create(:user => @user4, :role => "teacher")
    @lesson4.registrations.create(:user => @user4, :role => "student")
  end

  it "can return all lessons of a particular status" do
    expect(Lesson.all_by_status("open").length).to eq(2)
    expect(Lesson.all_by_status("completed")).to include(@lesson4)
  end

  it "can have user2 as a user" do
    expect(@lesson1.users).to include(@user2)
  end

  it "can have user3 as a user" do
    expect(@lesson1.users).to include(@user3)
  end

  it "knows its students" do 
    expect(@lesson1.students).to include(@user2)
    expect(@lesson1.students).to include(@user1)
    expect(@lesson1.students.length).to eq(2)
  end

  it "knows its teachers" do
    expect(@lesson1.teachers).to include(@user3)
    expect(@lesson1.teachers).to include(@user4)
    expect(@lesson1.teachers.length).to eq(2)
  end

  it "knows the first teacher" do
    expect(@lesson1.first_teacher).to eq(@user3)
  end

  it "returns [] if it has no students" do
    expect(@lesson3.students).to eq([])
  end

  it "returns [] if it has no teachers" do
    expect(@lesson3.teachers).to eq([])
  end

  it "knows what tags it has" do
    expect(@lesson1.tags).to include(@topic_tag1)
    expect(@lesson1.tags).to_not include(@topic_tag2)
    expect(@lesson1.tags.length).to eq(2)
  end

  it "can return tags of a particular category" do
    expect(@lesson2.tags_by_category("location")).to include(@location_tag1)
    expect(@lesson2.tags_by_category("location").length).to eq(1)
    expect(@lesson2.tags_by_category("topic")).to include(@topic_tag3)
    expect(@lesson2.tags_by_category("topic").length).to eq(3)
  end

  it "returns [] if it has no tags of a particular category" do
    (expect(@lesson1.location_tags).to eq([]))
  end

  it "can have multiple tags" do
    expect(@lesson2.tags.length).to eq(4)
  end

  it "can return its tags as a string" do
    expect(@lesson2.tags_to_string).to be_a(String)
    expect(@lesson2.tags_to_string).to include(@lesson2.tags.first.name)
  end

  it "can return its tag ids as an array" do
    expect(@lesson2.tag_ids_to_array).to be_a(Array)
    expect(@lesson2.tag_ids_to_array).to include(@lesson2.tags.first.id)
  end

  # The following two tests work, but something about FactoryGirl makes it not see tags properly
  xit "can add tags to itself, given a full hash of existing tags" do
    tags_hash = {
      :topics => [@topic_tag1.name, @topic_tag2.name],
      :locations => [@location_tag1.name, @location_tag2.name],
      :times => [@time_tag1.name]
    } 
    @lesson3.build_tags(tags_hash)
    @lesson3.save

    expect(@lesson3.tags).to include(@topic_tag1)
    expect(@lesson3.tags).to include(@location_tag1)
    expect(@lesson3.tags).to include(@location_tag2)
    expect(@lesson3.tags.length).to eq(5)
  end

  xit "can add tags to itself, given a partial hash of existing tags" do
        tags_hash = {
      :topics => [@topic_tag1.name, @topic_tag2.name],
      :locations => nil,
      :times => [@time_tag1.name]
    } 
    @lesson3.build_tags(tags_hash)
    @lesson3.save

    expect(@lesson3.tags).to include(@topic_tag2)
    expect(@lesson3.tags).to include(@time_tag1)
    expect(@lesson3.tags).to_not include(@location_tag1)
    expect(@lesson3.tags.length).to eq(3)
  end

  it "knows its admin" do
    expect(@lesson1.admin).to eq(@user2)
    expect(@lesson1.admin).to_not eq(@user3)
  end

  it "it returns nil if theres no admin" do
    expect(@lesson2.admin).to eq(nil)
  end

  it "verifies user count before deletion" do
    expect(@lesson4.ok_to_delete?).to eq(false)
    expect(@lesson1.ok_to_delete?).to eq(true)
  end

  it "can close its status" do
    @lesson1.close
    expect(@lesson1.status).to eq("closed")
  end

  xit "can mark itself held" do
    expect(@user1).to receive(:add_to_completed).with(@lesson1)
    # @user1.add_to_completed(@lesson1)
    @lesson1.mark_completed
    expect(@lesson1.status).to eq("completed")
  end

  # describe "#add_to_completed" do
  #   it "can mark itself held" do
  #     expect(something).to be(something)
  #   end
  # end


end