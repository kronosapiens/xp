# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :experience do
    user nil
    tag nil
    taken 1
    taught 1
    gh_stat 1
  end
end
