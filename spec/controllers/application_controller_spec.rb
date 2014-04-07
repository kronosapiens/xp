require 'spec_helper'

describe ApplicationController do

  describe 'current user' do

    it "returns nil for if there is no one logged in" do
      @request.reset_session
      expect(@controller.current_user).to eq(nil)
    end
    
  end

end
