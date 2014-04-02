require 'spec_helper'

describe ApplicationController do

  xit "returns nil for 'current_user' if there is no one logged in" do
    reset_session
    expect(current_user).to eq(nil)
  end

end
