require 'rails_helper'

RSpec.describe Search do
  use_moby_cats

  let(:lion) { Word.find_by(name: 'lion') }
  let(:tiger) { Word.find_by(name: 'tiger') }
  let(:tiger_group) { Group.find_by(key_word: tiger) }
  let(:search_query) { 'lion, tiger' }
  let(:search) { Search.new(search_query).tap(&:execute) }

  describe '#group_ids' do
    it 'returns an array of integers' do
      expect(search.group_ids[0]).to be_an Integer
    end

    it 'returns the correct value' do
      expect(search.group_ids).to include tiger_group.id
    end
  end

  describe '#missing_words' do
    it 'returns missing words in order' do
      search = Search.new('lion, wumpus, unicorn').tap(&:execute)
      expect(search.missing_words.size).to eq 2
      expect(search.missing_words.first).to eq 'wumpus'
      expect(search.missing_words.second).to eq 'unicorn'
    end
  end

  describe '#results' do
    it 'returns an array of weighted words' do
      result = search.results.first
      expect(result).to be_a Word
      expect(result.weight).to be_an Integer
    end

    it 'returns the correct number of results' do
      expect(search.results.size).to eq 9
    end

    it 'returns results between 1 and MAX_WEIGHT' do
      results = search.results

      expect(results.min_by(&:weight).weight).to eq 1
      expect(results.max_by(&:weight).weight).to eq Search::MAX_WEIGHT
    end

    it 'always includes the searched terms, regardless of MAX_RELATED_WORDS' do
      stub_const('Search::MAX_RELATED_WORDS', 1)

      result_names = search.results.map(&:name)
      expect(result_names).to include('lion', 'tiger')
    end

    context 'when part of speech is used' do
      let(:search_query) { 'lion, tiger pos:!' }
      
      it 'only returns the part of speech' do
        result_names = search.results.map(&:name)
        expect(result_names).to contain_exactly 'lion', 'tiger', 'bobcat'
      end
    end
  end

  describe 'validations' do
    describe 'presence_of :string' do
      it 'valid in presence of string' do
        search = Search.new('lion').tap(&:execute)
        expect(search).to be_valid
      end

      it 'invalid when string is empty' do
        search = Search.new('').tap(&:execute)
        expect(search).to_not be_valid
      end
    end

    describe ':words_exist' do
      it 'valid if words are in dictionary' do
        search = Search.new('cat, lion').tap(&:execute)
        expect(search).to be_valid
      end

      it 'invalid when words are not in dictionary' do
        search = Search.new('cat, numberwang').tap(&:execute)
        expect(search).to_not be_valid
      end
    end

    describe ':words_have_intersecting_groups' do
      it 'valid if groups intersect' do
        search = Search.new('lion, tiger').tap(&:execute)
        expect(search).to be_valid
      end

      it 'invalid if groups do not intersect' do
        search = Search.new('cat, platypus').tap(&:execute)
        expect(search).to_not be_valid
      end
    end
  end
end
