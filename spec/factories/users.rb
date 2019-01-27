# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'password' }
    confirmed_at { Time.current }

    trait :admin do
      is_admin { true }
    end

    factory :admin_user, traits: [:admin]
  end
end
