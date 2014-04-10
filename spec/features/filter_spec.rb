# require_relative '../feature_helper'

# describe "Filter for lessons" do
#   before(:each) do
#     @user = FactoryGirl.create(:user) 
#     @lesson = FactoryGirl.create(:lesson)
#   end

#   it 'allows you to filter out lessons not about CSS' do
#       $rspec_user_id = @user.id
#       visit('/')

#       within "#lesson_#{@lesson.id}" do
#         click_button "Take This!"
#       end

#       expect(page).to have_content("Sign up successful!")
#   end

# end