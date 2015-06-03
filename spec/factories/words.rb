# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :word do
    sequence(:name) { |n| "#{Faker::Lorem.word}#{n}" }
  end
end
