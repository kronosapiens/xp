require 'spec_helper'

describe LessonsController do
  let!(:user) { create(:user) }
  let!(:lesson) { create(:lesson) }

  before(:each) do
    $rspec_user_id = user.id
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "loads all active lessons" do
      get :index
      assigns(:lessons).should be_true
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: lesson.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      lesson.registrations.create(user: user, admin: true)
      get :edit, id: lesson.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      create(:tag)
      post :create, lesson: { title: "Test Lesson",  description: "Test Description", references: "Test References" }, :tags => ["1"]
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "PATCH 'update'" do
    it "returns http success" do
      lesson.registrations.create(user: user, admin: true)
      patch :update, id: lesson.id, lesson: { title: "Updated Test Lesson", description: "Updated Test Description", references: "Updated Test References", specific_location: "11 Broadway, NY, NY" }, :tags => ["1"]
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "PATCH 'update_status'" do
    it "returns http success" do
      lesson.registrations.create(user: user, admin: true)
      patch :update, id: lesson.id, lesson: { title: "Updated Test Lesson", status: "completed", description: "Updated Test Description", references: "Updated Test References" }, :tags => ["1"]
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      lesson.registrations.create(user: user, admin: true)
      delete :destroy, id: lesson.id
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

  describe "POST 'admin_email'" do
    it "returns http success" do
      lesson.registrations.create(user: user, admin: true)
      post :admin_email, id: lesson.id, subject: "Email subject", content: "Email content"
      expect(response).to be_redirect
      expect(response.status).to eq(302)
    end
  end

end