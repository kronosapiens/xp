require 'spec_helper'

describe "Registration" do

  before(:each) do
    @lesson1 = create(:lesson)

    @tag1 = create(:tag)
  
    @lesson1.lesson_tags.create(:tag => @tag1)

    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)

    @lesson1.registrations.create(:user => @user1, :role => "student", :admin => true)
    @lesson1.registrations.create(:user => @user2, :role => "teacher", :admin => false)
  end

  it "allows only one admin per lesson" do
    expect(@lesson1.registrations.where(:admin => true).length).to eq(1)
    @lesson1.registrations.create(:user_id => @user3.id, :role => "teacher", :admin => true)
    expect(@lesson1.registrations.where(:admin => true).length).to eq(1)
    expect(@lesson1.admin).to eq(@user1)
  end


end