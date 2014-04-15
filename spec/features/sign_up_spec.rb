require_relative '../feature_helper'

describe "Sign Up" do
  before(:each) do
    @user = FactoryGirl.create(:user) 
    @lesson = FactoryGirl.create(:lesson)
  end

it 'does allow you to take course if you are logged in' do
    $rspec_user_id = @user.id
    visit('/lessons')

    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end

    expect(page).to have_content("Sign up successful!")
end

it 'requires that you be logged in to take course' do

    visit('/lessons')
    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end
    expect(page).to have_content("You must be logged in")

  end

it 'does not allow you to take course twice' do
    $rspec_user_id = @user.id
    visit('/lessons')
    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end
    visit('/lessons')
    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end

    expect(page).to have_content("Sign up failed")
end

end

describe "Teach Lesson" do
  before(:each) do
    @user = FactoryGirl.create(:user) 
    @lesson = FactoryGirl.create(:lesson)
    
  end



end