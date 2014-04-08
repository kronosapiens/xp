FactoryGirl.define do 

  sequence :name do |n|
    "Tag #{n}"
  end

  factory :tag do 
    name 
  end
end