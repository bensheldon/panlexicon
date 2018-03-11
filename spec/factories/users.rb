FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.first_name }
    email { FFaker::Internet.email }
    password 'password'
    confirmed_at Time.zone.now

    trait :admin do
      is_admin true
    end

    factory :admin_user, traits: [:admin]
  end
end
