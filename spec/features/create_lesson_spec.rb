require_relative '../feature_helper'

describe "Teach Lesson" do
    let(:user){ create(:user) }
    let(:lesson){ create(:lesson) }

  it 'requires login to create lesson' do
    visit(root_path)
    within ".navbar" do
      click_link "Teach Lesson"
    end

    expect(page).to have_content("You must be logged in to take this action.")
  end

  it 'serves up a create-as-teacher form' do
    $rspec_user_id = user.id

    visit(root_path)
    within ".navbar" do
      click_link "Teach Lesson"
    end

    expect(page).to have_content("Teach a New Lesson")
  end

  xit 'allows you to create a lesson', js: true do
    $rspec_user_id = user.id

    visit('lessons/new?role=teacher')
    within "#new_lesson" do
      fill_in 'Title', :with => "Test Title"
      fill_in 'Description', :with => "Test Description"
      click_on 'Ruby'
      fill_in 'References', :with => "Test References"
    end
    click_link 'Submit'
    expect(page).to have_content 'Lesson was successfully created!'    
  end

  it 'requires at least one tag to be selected' do
    $rspec_user_id = user.id

    visit('lessons/new?role=teacher')
    within "#new_lesson" do
      fill_in 'Title', :with => "Test Title"
      fill_in 'Description', :with => "Test Description"
      fill_in 'References', :with => "Test References"
    end
    click_button 'Submit'
    expect(page).to have_content 'Tags Lesson must have at least one tag.'   
  end

end