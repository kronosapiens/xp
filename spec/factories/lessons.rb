FactoryGirl.define do 

  sequence :title do |n|
    "Mind Blowing Knowledge #{n}"
  end

  factory :lesson do 
    title 
    description "Super awesome lesson that will change your life"
    references "github.com/something"
    specific_time DateTime.now
    specific_location "Flatiron Quad"
    status "open"

    before(:create) do |lesson|
      lesson.tags << FactoryGirl.create(:tag)
    end
  
  end
end