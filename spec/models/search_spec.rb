require 'spec_helper'

describe Search do

  use_moby_cats

  let(:lion) { Word.find_by(name: 'lion') }
  let(:tiger) { Word.find_by(name: 'tiger') }
  let(:tiger_group) { Group.find_by(key_word: tiger)}
  let(:search) { Search.new [lion, tiger] }

  describe '#intersect_gids' do
    it 'returns an array of integers' do
      expect(search.intersect_gids[0]).to be_an Integer
    end

    it 'returns the correct value' do
      expect(search.intersect_gids).to include tiger_group.id
    end
  end

  describe '#words_with_raw_group_counts' do
    it 'returns an array of words' do
      expect(search.words_with_raw_group_counts[0]).to be_a Word
    end

    it 'returns words with search_group_counts' do
      word = search.words_with_raw_group_counts[0]
      expect(word.search_group_count).to eq 1
    end

    it 'returns words with a search_bucket' do
      word = search.words_with_raw_group_counts[0]
      expect(word.search_bucket).to eq 1
    end
  end
end
