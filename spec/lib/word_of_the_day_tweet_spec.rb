require 'rails_helper'

RSpec.describe WordOfTheDayTweet do
  use_moby_cats

  let(:word_of_the_day) { WordOfTheDay.create word: Word.find_by_name('lion') }
  let(:tweeter) { described_class.new word_of_the_day }
  let(:twitter_client) do
    # stub out the twitter_client
    double('twitter_client').tap do |twitter_client|
      allow(tweeter).to receive(:twitter_client) { twitter_client }
    end
  end

  describe '#generate!' do
    it 'invokes twitter_client#update' do
      expect(twitter_client).to receive(:update)
      tweeter.generate!
    end

    describe 'tweeted message' do
      let(:tweet) do
        tweet = nil
        allow(twitter_client).to receive(:update) do |msg|
          tweet = msg
        end
        tweeter.generate!
        tweet
      end

      it 'includes the word of the day name' do
        expect(tweet).to include word_of_the_day.word.name
      end

      it 'includes related words' do
        expect(tweet).to include(*%w(bobcat lynx puma leopard tiger))
      end

      it 'includes link to the website' do
        link = tweet.split.last
        expect(link).to match URI.regexp %w(http https)
      end
    end
  end
end
