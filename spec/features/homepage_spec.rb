require_relative '../feature_helper'
 

describe "Homepage" do
  
  it 'returns a 200' do
    visit '/'
    expect(page.status_code).to eq(200)
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