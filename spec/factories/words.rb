# frozen_string_literal: true

FactoryBot.define do
  factory :word do
    sequence(:name) { |n| "#{FFaker::Lorem.word}#{n}" }
  end
end
