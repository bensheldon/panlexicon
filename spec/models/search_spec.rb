require 'spec_helper'

describe Search do

  use_moby_cats

  let(:lion) { Word.find_by(name: 'lion') }
  let(:tiger) { Word.find_by(name: 'tiger') }
  let(:tiger_group) { Group.find_by(key_word: tiger) }
  let(:search) { Search.new 'lion, tiger' }

  describe '#group_ids' do
    it 'returns an array of integers' do
      expect(search.group_ids[0]).to be_an Integer
    end

    it 'returns the correct value' do
      expect(search.group_ids).to include tiger_group.id
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
      stub_const('WeightedWord', weighted_word_class)

      expect(weighted_word_class).to receive(:new).with({
        'id' => "#{lion.id}",
        'name' => 'lion',
        'groups_count' => '7',
        'bucket' => '8'
      })

      search.weight_related_words
    end
  end

  describe 'validations' do
    describe 'presence_of :string' do
      it 'valid in presence of string' do
        search = Search.new('lion')
        expect(search.valid?).to be true
      end

      it 'invalid when string is empty' do
        search = Search.new('')
        expect(search.valid?).to be false
      end
    end

    describe ':words_exist' do
      it 'valid if words are in dictionary' do
        search = Search.new('cat, lion')
        expect(search.valid?).to be true
      end

      it 'invalid when string is empty' do
        search = Search.new('cat, numberwang')
        expect(search.valid?).to be false
      end
    end

    describe ':words_have_intersecting_groups' do
      it 'valid if groups intersect' do
        search = Search.new('lion, tiger')
        expect(search.valid?).to be true
      end

      it 'invalid if groups do not intersect' do
        search = Search.new('cat, platypus')
        expect(search.valid?).to be false
      end
    end
  end
end
