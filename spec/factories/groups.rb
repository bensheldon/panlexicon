# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    key_term { FactoryGirl.create :term }
  end
end
