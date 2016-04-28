require 'spec_helper'

RSpec.describe SearchRecord, type: :model do
  use_moby_cats

  let(:search) { Search.new('lion, tiger').tap(&:execute) }
  let(:search_record) { described_class.create_from_search search }

  describe '::create_from_search' do
    it 'returns a new SearchRecord object' do
      search_record = SearchRecord.create_from_search search
      expect(search_record).to be_a SearchRecord
    end
  end

  describe '::destroy_expired' do
    before(:each) do
      Timecop.travel((SearchRecord::STORAGE_LIFETIME + 1.day).ago) do
        SearchRecord.create_from_search Search.new('lion').tap(&:execute)
      end
      SearchRecord.create_from_search Search.new('lion, tiger').tap(&:execute)
    end

    it 'deletes SearchRecords past their lifetime expiration' do
      expect(SearchRecord.count).to eq 2
      SearchRecord.delete_expired
      expect(SearchRecord.count).to eq 1
    end
  end

  describe 'word order' do
    it 'returns words in same order as original search' do
      lion_first = SearchRecord.create_from_search Search.new('lion, tiger').tap(&:execute)
      tiger_first = SearchRecord.create_from_search Search.new('tiger, lion').tap(&:execute)

      expect(lion_first.words.first.name).to eq 'lion'
      expect(tiger_first.words.first.name).to eq 'tiger'
    end
  end
end
