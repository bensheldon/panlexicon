require 'spec_helper'

describe Search do

  use_moby_cats

  let(:lion) { Word.find_by(name: 'lion') }
  let(:tiger) { Word.find_by(name: 'tiger') }
  let(:tiger_group) { Group.find_by(key_word: tiger)}
  let(:search) { Search.new 'lion, tiger' }

  describe '#intersect_gids' do
    it 'returns an array of integers' do
      expect(search.intersect_group_ids[0]).to be_an Integer
    end

    it 'returns the correct value' do
      expect(search.intersect_group_ids).to include tiger_group.id
    end
  end

  describe '#weighted_words' do
    it 'returns an array of WeightedWords' do
      expect(search.weight_related_words.first).to be_a WeightedWord
    end

    it 'calls WeightedWord.new for every returned word' do
      expect(WeightedWord).to receive(:new).exactly(9).times
      search.weight_related_words
    end

    it 'calls WeightedWord.new with a hash' do
      # necessary because WeightedWord.new is called multiple times
      weighted_word_class = double().as_null_object
      stub_const("WeightedWord", weighted_word_class)

      expect(weighted_word_class).to receive(:new).with({
        'id' => "#{lion.id}",
        'name' => 'lion',
        'groups_count' => '7',
        'bucket' => '8'
      })

      search.weight_related_words
    end
  end
end
