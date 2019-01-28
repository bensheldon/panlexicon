# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    key_word { FactoryBot.create :word }
  end
end
