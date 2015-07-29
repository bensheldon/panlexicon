require 'spec_helper'

RSpec.describe SearchRecordsByDate, type: :model do
  use_moby_cats

  let(:search) { Search.new 'lion, tiger' }
  let!(:search_record) { SearchRecord.create_from_search search }
  let(:records) { SearchRecordsByDate.new Time.now.utc.to_date }

  describe '#results' do
    it 'includes searched words' do
      expect(records.results.size).to eq search_record.words.size
    end

    it 'weights words' do
      expect(records.results.first.weight).to be_an Integer
    end
  end
end
