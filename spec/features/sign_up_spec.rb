require_relative '../feature_helper'

describe "Sign Up" do
  before(:each) do
    @user = FactoryGirl.create(:user) 
    @lesson = FactoryGirl.create(:lesson) unless @lesson
    
  end


it 'requires that you be logged in to take course' do
    # user = FactoryGirl.create(:user) 
    # lesson = FactoryGirl.create(:lesson)
    # #tag = create(:tag)
    visit('/')
    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end
    expect(page).to have_content("You must be logged in")
  end

end