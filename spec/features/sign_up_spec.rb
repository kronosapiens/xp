require_relative '../feature_helper'

describe "Sign Up" do
  before(:each) do
    @user = FactoryGirl.create(:user) 
    @lesson = FactoryGirl.create(:lesson)
    
  end

it 'does allow you to take course if you are logged in' do
    $rspec_user_id = @user.id
    visit('/')

    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end

    expect(page).to have_content("Sign Up Successful!")
end

it 'requires that you be logged in to take course' do

    visit('/')
    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end
    expect(page).to have_content("You must be logged in")

  end

it 'does not allow you to take course twice' do
    $rspec_user_id = @user.id
    visit('/')
    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end
    visit('/')
    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end

    expect(page).to have_content("Sign Up Failed")
end

end

describe "Teach Lesson" do
  before(:each) do
    @user = FactoryGirl.create(:user) 
    @lesson = FactoryGirl.create(:lesson)
    
  end



end