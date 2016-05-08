# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :word do
    sequence(:name) { |n| "#{FFaker::Lorem.word}#{n}" }
  end
end
