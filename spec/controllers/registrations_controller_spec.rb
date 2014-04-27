require 'spec_helper'

describe RegistrationsController do
  let(:user) { create(:user) }
  let(:lesson) { create(:lesson) }

  before(:each) do
    $rspec_user_id = user.id
  end

  describe "POST 'create'" do
    it "returns http success" do
      post :create, lesson_id: lesson.id, user_id: user.id, registration: { role: :student }
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "PATCH 'update'" do 
    it "returns http success" do 
      registration = lesson.registrations.create(user: user, admin: true)
      patch :update, id: registration.id, lesson_id: lesson.id, user_id: user.id, registration: { admin: false }
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end 
  end 

  describe "DELETE 'destroy'" do
    it "returns http success" do
      registration = lesson.registrations.create(user: user, admin: false)
      delete :destroy, id: registration.id, lesson_id: lesson.id, user_id: user.id, registration: { admin: false }
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end
end
