FactoryGirl.define do 

  sequence :title do |n|
    Faker::Name.name + n.to_s
  end

  factory :lesson do 
    title
    description { Faker::Lorem.sentence }
    references { Faker::Internet.url }
    specific_time { DateTime.now }
    specific_location { Faker::Address.street_address }

    trait :completed do
      status 'completed'
    end

    trait :closed do
      status 'closed'
    end

    before(:create) do |lesson|
      lesson.tags << create(:tag)
    end
  
  end
end