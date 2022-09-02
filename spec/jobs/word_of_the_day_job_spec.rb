# frozen_string_literal: true
require 'rails_helper'

RSpec.describe WordOfTheDayJob do
  use_moby_cats

  let(:word_of_the_day) { WordOfTheDay.create word: Word.find_by(name: 'lion') }
  let(:tweet) { Struct.new(:text, :url).new("The tweet", "https://twitter.com/the-tweet") }

  describe '#perform' do
    it 'does not error' do
      allow(WordOfTheDayGenerator).to receive(:generate!).and_return(word_of_the_day)
      allow(WordOfTheDayTweet).to receive(:generate!).and_return(tweet)

      job = described_class.new
      job.perform
    end
  end
end
