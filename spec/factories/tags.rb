FactoryGirl.define do 

  sequence :name do |l|
    "Bass #{l}"
  end

  factory :tag do 
    name 
  end
end