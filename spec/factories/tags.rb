FactoryGirl.define do 

  sequence :name do |l|
    "Guitar #{l}"
  end

  factory :tag do 
    name 
  end
end