require 'spec_helper'

describe "Registration" do
  let(:lesson1){ create(:lesson) }
  let(:user1){ create(:user) }
  let(:user2){ create(:user) }

  before(:each) do
    lesson1.registrations.create(:user => user1, :role => "student", :admin => true)
  end

  describe 'model validations' do
    it "allows only one admin per lesson" do
      expect(lesson1.registrations.where(:admin => true).length).to eq(1)

      lesson1.registrations.create(:user_id => user2.id, :role => "teacher", :admin => true)

      expect(lesson1.registrations.where(:admin => true).length).to eq(1)
      expect(lesson1.admin).to eq(user1)
    end
  end


end