# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group do
  let(:group) { build :group }

  it 'has a valid factory' do
    group = build :group
    expect(group).to be_valid
  end

  it 'requires a key_word' do
    group = build :group, key_word: nil
    expect(group).not_to be_valid
  end

  it 'has many words' do
    word1 = create :word
    word2 = create :word

    group.words += [word1, word2]
  end
end
