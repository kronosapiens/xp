FactoryGirl.define do 
  sequence :uid do |id|
    "12345#{id}"
  end

  factory :user do 
    uid
    name "Eevee"
    nickname "e3ve3"
    image_url "http://cdn.bulbagarden.net/upload/thumb/e/e2/133Eevee.png/250px-133Eevee.png"
  end
end