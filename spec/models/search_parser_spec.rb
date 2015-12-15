require 'spec_helper'

RSpec.describe SearchParser do
  use_moby_cats

  describe '#fragments' do
    it 'returns fragments in search order' do
      lion_first = SearchParser.new('Lion, tiger').tap(&:execute)
      tiger_first = SearchParser.new('Tiger, lion').tap(&:execute)

      expect(lion_first.fragments.first.string).to eq 'Lion'
      expect(tiger_first.fragments.first.string).to eq 'Tiger'
    end
  end
  describe '#words' do
    it 'returns Words' do
      parser = SearchParser.new('Lion, wumpus, unicorn').tap(&:execute)
      expect(parser.words.first).to be_a Word
      expect(parser.words.first.name).to eq 'lion'
    end
  end

  describe '#missing_words' do
    it 'returns missing words in order' do
      parser = SearchParser.new('lion, wumpus, unicorn').tap(&:execute)
      expect(parser.missing_words.size).to eq 2
      expect(parser.missing_words.first).to eq 'wumpus'
      expect(parser.missing_words.second).to eq 'unicorn'
    end
  end
end
