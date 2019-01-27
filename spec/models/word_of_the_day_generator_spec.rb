# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WordOfTheDayGenerator do
  let(:generator) { described_class.new }

  describe '#generate!' do
    use_moby_cats

    it 'returns and persists a word of the day' do
      word_of_the_day = generator.generate!
      expect(word_of_the_day).to be_persisted
    end

    describe 'when search records exist' do
      before do
        temp_wod = WordOfTheDay.new(date: Time.zone.today)
        Timecop.travel(temp_wod.records_start_at + 1.hour) do
          SearchRecord.create_from_search Search.new('lion').tap(&:execute)
          SearchRecord.create_from_search Search.new('lion, tiger').tap(&:execute)
        end
      end

      it "generates the most searched word" do
        word_of_the_day = generator.generate!
        expect(word_of_the_day.word.name).to eq 'lion'
      end

      it "returns the most searched word that doesn't match a previous searched word" do
        WordOfTheDay.create! word: Word.find_by(name: 'lion'), date: (Time.zone.today - 2.days)

        word_of_the_day = generator.generate!
        expect(word_of_the_day.word.name).to eq 'tiger'
      end
    end
  end
end
