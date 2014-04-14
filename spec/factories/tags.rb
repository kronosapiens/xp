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
  end

end