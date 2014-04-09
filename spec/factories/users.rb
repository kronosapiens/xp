FactoryGirl.define do 

  factory :user do 
    uid { rand(10000) }
    name { Faker::Name.name }
    nickname { Faker::Lorem.word + rand(100).to_s }
    email { Faker::Internet.email }
    image_url "http://cdn.bulbagarden.net/upload/thumb/e/e2/133Eevee.png/250px-133Eevee.png"
  end

end