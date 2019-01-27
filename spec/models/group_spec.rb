# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group do
  let(:group) { FactoryBot.build :group }

  it 'has a valid factory' do
    group = FactoryBot.build :group
    expect(group).to be_valid
  end

  it 'requires a key_word' do
    group = FactoryBot.build :group, key_word: nil
    expect(group).not_to be_valid
  end

  it 'has many words' do
    word1 = FactoryBot.create :word
    word2 = FactoryBot.create :word

    group.words += [word1, word2]
  end
end
