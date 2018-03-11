require 'rails_helper'

RSpec.describe Group do
  let(:group) { FactoryBot.build :group }

  it 'has a valid factory' do
    group = FactoryBot.build :group
    expect(group).to be_valid
  end

  it 'requires a key_word' do
    group = FactoryBot.build :group, key_word: nil
    expect(group).to_not be_valid
  end

  it 'has many words' do
    word_1 = FactoryBot.create :word
    word_2 = FactoryBot.create :word

    group.words += [word_1, word_2]
  end
end
