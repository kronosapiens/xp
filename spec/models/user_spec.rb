require 'spec_helper'

describe "User" do

  before(:each) do
    @front_end_lesson = create(:lesson)
    @back_end_lesson = create(:lesson)
    @jquery_lesson = create(:lesson)
    @arel_lesson = create(:lesson)

    @jquery_lesson.update(:status => "completed")
    @back_end_lesson.update(:status => "closed")
  
    @css = create(:tag)
    @jquery = create(:tag)
    @rails = create(:tag)
    @arel = create(:tag)
  
    @front_end_lesson.lesson_tags.create(:tag => @css)
    @front_end_lesson.lesson_tags.create(:tag => @jquery)
    @back_end_lesson.lesson_tags.create(:tag => @rails)
    @back_end_lesson.lesson_tags.create(:tag => @arel)
    @back_end_lesson.lesson_tags.create(:tag => @jquery)
    @jquery_lesson.lesson_tags.create(:tag => @jquery)
    @jquery_lesson.lesson_tags.create(:tag => @css)
    @arel_lesson.lesson_tags.create(:tag => @arel)
  
    @ash = create(:user)
    @misty = create(:user)

    @ash.registrations.create(:lesson => @front_end_lesson, :role => "teacher")
    @ash.registrations.create(:lesson => @jquery_lesson, :role => "student")

    @misty.registrations.create(:lesson => @front_end_lesson, :role => "student")
    @misty.registrations.create(:lesson => @jquery_lesson, :role => "teacher")
    @misty.registrations.create(:lesson => @back_end_lesson, :role => "student")
    @misty.registrations.create(:lesson => @arel_lesson, :role => "teacher")

    @auth_hash = {
     "provider"=>"github",
     "uid"=>"1874062",
     "info"=>
     {"nickname"=>"kronosapiens",
       "email"=>"kronovet@gmail.com",
       "name"=>"Daniel Kronovet",
       "image"=>"https://avatars.githubusercontent.com/u/1874062?"}
     }
  end

  it 'knows what lessons it has' do
    expect(@misty.lessons.first).to eq(@front_end_lesson)
    expect(@misty.lessons.length).to eq(4)
  end

  it 'knows when it is a student' do
    expect(@misty.lessons_by_role("student").first).to eq(@front_end_lesson) 
  end

  it 'knows when it is a teacher' do
    expect(@misty.lessons_by_role("teacher").first).to eq(@jquery_lesson)
  end

  it 'knows its open lessons as a student' do 
    desired_lessons = @misty.lessons_by_role_and_status("student", "open")

    expect(desired_lessons).to include(@front_end_lesson)
    expect(desired_lessons).to_not include(@arel_lesson) 
  end

  it 'knows its upcoming lessons as a student' do 
    desired_lessons = (@misty.lessons_by_role_and_status("student", "open") + @misty.lessons_by_role_and_status("student", "closed"))

    expect(desired_lessons).to include(@front_end_lesson)
    expect(desired_lessons).to_not include(@arel_lesson) 
  end

  it 'knows its completed lessons as a teacher' do 
    desired_lessons = (@misty.lessons_by_role_and_status("teacher", "completed"))

    expect(desired_lessons).to include(@jquery_lesson)
    expect(desired_lessons).to_not include(@arel_lesson) 
  end

  xit 'knows its lessons by tag' do
    expect(@misty.lessons_by_tag(@css).length).to eq(2)
    expect(@misty.lessons_by_tag(@css)).to include(@jquery_lesson)
  end
  
  it 'can create a user from oauth' do
    user = User.create_by_oauth(@auth_hash)
    expect(user.uid).to eq("1874062")
    expect(user.email).to eq("kronovet@gmail.com")
  end

  it 'can find a user from oauth' do
    user = User.create_by_oauth(@auth_hash)
    expect(User.find_or_create_by_oauth(@auth_hash)).to eq(user)
  end

  it 'can return the top users by tag and role' do
    expect(User.ranked_by_tag_and_role(@jquery, "student").first).to eq(@misty)
  end

end











