require 'spec_helper'

describe Group do
  let(:group){ FactoryGirl.build :group }

  it "has a valid factory" do
    group = FactoryGirl.build :group
    expect(group).to be_valid
  end

  it "requires a key_word" do
    group = FactoryGirl.build :group, key_word: nil
    expect(group).to_not be_valid
  end

  it "has many words" do
    word_1 = FactoryGirl.create :word
    word_2 = FactoryGirl.create :word

    group.words += [word_1, word_2]
  end

end
