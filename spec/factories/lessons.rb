FactoryGirl.define do 

  sequence :title do |l|
    "Guitar Lesson With Mike #{l}"
  end

  factory :lesson do 
    title 
    description "1 hour of steaming shred sesh!"
    references "Bob and Mike"
    specific_time DateTime.now
    specific_location "My house"
    status "open"

    before(:create) do |lesson|
      lesson.tags << FactoryGirl.create(:tag)
    end
  

  end
end