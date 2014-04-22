require 'spec_helper'

describe SessionsController do
  let!(:user) { create(:user) }

  before(:each) do
    $rspec_user_id = user.id
  end

  describe "GET 'oauth'" do
    xit "returns http success" do
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get :destroy
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "#login" do
    it "logs in the user" do
      @controller.login(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe "#flatiron_student?" do
    it "returns true for flatiron student" do
      flatiron_token = "f657b84d292b178211377015c8bdffeb012aec49"
      expect(@controller.flatiron_student?(flatiron_token)).to eq(true)
    end
  end

end
