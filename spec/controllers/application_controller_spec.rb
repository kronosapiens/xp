require 'spec_helper'

describe ApplicationController do

  before(:each) do
    @lesson1 = create(:lesson)
    @lesson2 = create(:lesson)
    @lesson2.update(:status => "closed")

    @topic_tag1 = create(:tag)
    @topic_tag2 = create(:tag)

    @topic_tag1.lesson_tags.create(:lesson => @lesson1)
    @topic_tag1.lesson_tags.create(:lesson => @lesson2)
    @topic_tag2.lesson_tags.create(:lesson => @lesson2)
  end

  describe 'current user' do
    it "returns nil for if there is no one logged in" do
      @request.reset_session
      expect(@controller.current_user).to eq(nil)
    end
  end

  it "can return all tags with multiple scopes" do
    
    @controller.get_tags(:active)
    expect(@topic_tags).to include(@topic_tag1)
  end

end
