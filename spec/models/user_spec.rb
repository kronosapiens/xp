require 'spec_helper'

describe "User" do

  before(:each) do
    @lesson1 = create(:lesson)
    @lesson2 = create(:lesson)
    @lesson3 = create(:lesson)
    @lesson4 = create(:lesson)

    @lesson3.update(:status => "completed")
    @lesson2.update(:status => "closed")
  
    @tag1 = create(:tag)
    @tag2 = create(:tag)
    @tag3 = create(:tag)
    @tag4 = create(:tag)
  
    @lesson1.tags << @tag1
    @lesson1.tags << @tag2
    @lesson2.lesson_tags.create(:tag => @tag3)
    @lesson2.lesson_tags.create(:tag => @tag4)
    @lesson2.lesson_tags.create(:tag => @tag2)
    @lesson3.lesson_tags.create(:tag => @tag2)
    @lesson3.lesson_tags.create(:tag => @tag1)
    @lesson4.lesson_tags.create(:tag => @tag4)
  
    @user1 = create(:user)
    @user2 = create(:user)

    @user1.registrations.create(:lesson => @lesson1, :role => "teacher")
    @user1.registrations.create(:lesson => @lesson3, :role => "student")
    @user2.registrations.create(:lesson => @lesson1, :role => "student")
    @user2.registrations.create(:lesson => @lesson2, :role => "student")
    @user2.registrations.create(:lesson => @lesson3, :role => "teacher")
    @user2.registrations.create(:lesson => @lesson4, :role => "teacher")

    @auth_hash = {
     "provider"=>"github",
     "uid"=>"1874062",
     "info"=>{
      "nickname"=>"kronosapiens",
      "email"=>"kronovet@gmail.com",
      "name"=>"Daniel Kronovet",
      "image"=>"https://avatars.githubusercontent.com/u/1874062?"
      },
     "credentials"=>{
      "token"=> "asdfkjl98w89alsdhf089q4thalshdfg0wet"
      }
    }
  end
    
  describe '::find_or_create_by_oauth' do
    it 'can find a user from oauth' do
      user = User.create_by_oauth(@auth_hash)
      expect(User.find_or_create_by_oauth(@auth_hash)).to eq(user)
    end

    it 'can create a user from oauth' do
      user = User.find_or_create_by_oauth(@auth_hash)
      expect(user.uid).to eq("1874062")
      expect(user.email).to eq("kronovet@gmail.com")
    end

    it 'can update a user auth token' do
      user = User.create_by_oauth(@auth_hash)
      @auth_hash["credentials"]["token"] = "asdflkq390sf440sfknq38"
      user = User.find_or_create_by_oauth(@auth_hash)
      expect(user.uid).to eq("1874062")
      expect(user.token).to eq("asdflkq390sf440sfknq38")
    end
  end

  describe '::ranked_by_tag_and_role' do
    it 'can return the top users by tag and role' do
      expect(User.ranked_by_tag_and_role(@tag2, "student").first).to eq(@user2)
    end
  end

  describe '#lessons_by_role' do
    it 'knows when it is a student' do
      expect(@user2.lessons_by_role("student").first).to eq(@lesson1) 
    end
  end

  describe '#lessons_by_role_and_status' do
    it 'knows its open lessons as a student' do 
      desired_lessons = @user2.lessons_by_role_and_status("student", "open")

      expect(desired_lessons).to include(@lesson1)
      expect(desired_lessons).to_not include(@lesson4) 
    end

    it 'knows its upcoming lessons as a student' do 
      desired_lessons = (@user2.lessons_by_role_and_status("student", "open") + @user2.lessons_by_role_and_status("student", "closed"))

      expect(desired_lessons).to include(@lesson1)
      expect(desired_lessons).to_not include(@lesson4) 
    end

    it 'knows its completed lessons as a teacher' do 
      desired_lessons = (@user2.lessons_by_role_and_status("teacher", "completed"))

      expect(desired_lessons).to include(@lesson3)
      expect(desired_lessons).to_not include(@lesson4) 
    end
  end

  describe '#add_to_completed' do
    it 'creates experiences when lessons are marked completed' do
      @user1.add_to_completed(@lesson1)
      expect(@user1.experiences.length).to eq(3) 
    end

    it 'creates new experiences if the user has never seen that tag before' do
      @user1.add_to_completed(@lesson1)
      expect(@user1.experiences).to include(Experience.where(:tag => @tag1).first)
    end
  end

  describe '#experience_with' do
    it 'can return an experience by name' do
      @user1.add_to_completed(@lesson1)
      tag_name = @lesson1.tags.first.name
      tag_id = @lesson1.tags.first.id
      test_tag = Experience.where("tag_id = ? AND user_id = ?", tag_id, @user1.id).first
      expect(@user1.experience_with(tag_name)).to eq(test_tag)
    end
  end

  describe '#update_xp' do
    it 'can add a new experience for a new language' do
      language_array = [{:Ruby=>4118, :CSS=>6040}, {:Arduino=>2285, :JavaScript=>1078, :Ruby=>965}]
      @user1.update_xp(language_array)
      expect(@user1.experience_with("Ruby").gh_stat).to eq(5083) 
    end
  end

  describe '#clear_gh_stats' do
    it 'can clear all the github code information' do
      language_array = [{:Ruby=>4118, :CSS=>6040}, {:Arduino=>2285, :JavaScript=>1078, :Ruby=>965}]
      @user1.update_xp(language_array)
      @user1.clear_gh_stats
      expect(@user1.experience_with("Ruby").gh_stat).to eq(0) 
    end
  end

end











