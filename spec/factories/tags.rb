FactoryGirl.define do

  sequence :name do |n|
    Faker::Lorem.word + n.to_s
  end

  factory :tag do 
    name

    trait :topic do
      category 'topic'
    end

    trait :language do
      category 'language'
    end

    trait :time do
      category 'time'
    end

    trait :location do
      category 'location'
    end
  end

end