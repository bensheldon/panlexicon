# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchRecord, type: :model do
  use_moby_cats

  let(:user) { create :user }
  let(:search) { Search.new('lion, tiger').tap(&:execute) }
  let(:search_record) { described_class.create_from_search search }

  describe '::create_from_search' do
    it 'returns a new SearchRecord object' do
      search_record = described_class.create_from_search search
      expect(search_record).to be_a described_class
    end
  end

  describe '::destroy_expired' do
    before do
      Timecop.travel((SearchRecord::STORAGE_LIFETIME + 1.day).ago) do
        described_class.create_from_search Search.new('lion').tap(&:execute)
        described_class.create_from_search Search.new('bobcat').tap(&:execute), user: user
      end
      described_class.create_from_search Search.new('lion, tiger').tap(&:execute)
    end

    it 'deletes SearchRecords past their lifetime expiration' do
      expect(described_class.count).to eq 3
      described_class.delete_expired
      expect(described_class.count).to eq 2
    end

    it 'does not delete SearchRecords associated with a user' do
      described_class.delete_expired
      expect(described_class.where.not(user: nil).count).to eq 1
    end
  end

  describe 'word order' do
    it 'returns words in same order as original search' do
      lion_first = described_class.create_from_search Search.new('lion, tiger').tap(&:execute)
      tiger_first = described_class.create_from_search Search.new('tiger, lion').tap(&:execute)

      expect(lion_first.words.first.name).to eq 'lion'
      expect(tiger_first.words.first.name).to eq 'tiger'
    end
  end
end
