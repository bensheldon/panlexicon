# frozen_string_literal: true

FactoryBot.define do
  factory :word do
    sequence(:name) { |n| "#{Faker::Lorem.word}#{n}" }
  end
end
