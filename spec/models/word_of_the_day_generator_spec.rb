require 'spec_helper'

RSpec.describe WordOfTheDayGenerator do
  let(:generator) { WordOfTheDayGenerator.new }

  describe '#generate!' do
    use_moby_cats

    it 'returns and persists a word of the day' do
      word_of_the_day = generator.generate!
      expect(word_of_the_day).to be_persisted
    end

    describe 'when search records exist' do
      before :each do
        temp_wod = WordOfTheDay.new(date: Date.today)
        Timecop.travel(temp_wod.records_start_at + 1.hour) do
          SearchRecord.create_from_search Search.new 'lion'
          SearchRecord.create_from_search Search.new 'lion, tiger'
        end
      end

      it "generates the most searched word" do
        word_of_the_day = generator.generate!
        expect(word_of_the_day.word.name).to eq 'lion'
      end

      it "returns the most searched word that doesn't match a previous searched word" do
        WordOfTheDay.create! word: Word.find_by_name('lion'), date: (Date.today - 2.days)

        word_of_the_day = generator.generate!
        expect(word_of_the_day.word.name).to eq 'tiger'
      end
    end
  end
end
