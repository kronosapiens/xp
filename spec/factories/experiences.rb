# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :experience do
    user_id { rand(100) }
    tag_id { rand(100) }
    taken { rand(100) }
    taught { rand(100) }
    gh_stat { rand(1000) }
  end

end