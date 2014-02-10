require 'spec_helper'

describe Search do

  uses_moby_data

  let(:cat) { Word.find_by(name: 'cat') }
  let(:dog) { Word.find_by(name: 'dog') }
  let(:cat_group) { Group.find_by(key_word: cat)}
  let(:search) { Search.new [cat, dog] }

  describe '#intersect_gids' do
    it 'returns an array of integers' do
      expect(search.intersect_gids[0]).to be_an Integer
    end

    it 'returns the correct value' do
      expect(search.intersect_gids).to include cat_group.id
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
