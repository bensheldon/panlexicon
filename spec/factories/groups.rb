FactoryBot.define do
  factory :group do
    key_word { FactoryBot.create :word }
  end
end
