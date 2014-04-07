require_relative '../feature_helper'
 

describe "Homepage" do
  before(:each) do
    @user = FactoryGirl.create(:user) 
    @lesson = FactoryGirl.create(:lesson)
  end
  
  it 'returns a 200' do
    visit '/'
    expect(page.status_code).to eq(200)
  end

  it 'able to sign up for a course' do
    # user = FactoryGirl.create(:user) 
    # lesson = FactoryGirl.create(:lesson)
    # #tag = create(:tag)
    visit('/')
    within "#lesson_#{@lesson.id}" do
      click_button "Take This!"
    end
    expect(page.status_code).to eq(300)
  end


end



# module IntegrationSpecHelper
#   def login_with_oauth(service = :github)
#     visit "/auth/#{service}"
#   end
# end

# feature 'testing oauth' do
#   scenario 'should create a new user' do
#     login_with_oauth
#     visit show_user_path ### changed from new_user_path just in case

#     # fill_in 'tiger_name', :with => 'Charlie'
#     # fill_in 'tiger_blood', :with => 'yes'
    
#     # click_on 'Create Tiger'
    
#     page.should have_content(:nickname)
#   end
# end