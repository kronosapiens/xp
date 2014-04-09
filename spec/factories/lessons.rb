FactoryGirl.define do 

  factory :lesson do 
    title { Faker::Name.name + rand(1000).to_s }
    description { Faker::Lorem.sentence }
    references { Faker::Internet.url }
    specific_time { DateTime.now }
    specific_location { Faker::Address.street_address }

    before(:create) do |lesson|
      lesson.tags << create(:tag)
    end
  
  end
end