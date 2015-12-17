require 'spec_helper'

RSpec.describe WordOfTheDayTweet do
  use_moby_cats

  let(:word_of_the_day) { WordOfTheDay.create word: Word.find_by_name('lion') }
  let(:tweeter) { WordOfTheDayTweet.new word_of_the_day }
  let(:twitter_client) {
    # stub out the twitter_client
    double('twitter_client').tap { |twitter_client|
      allow(tweeter).to receive(:twitter_client) { twitter_client }
    }
  }

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

      it "includes the word of the day name" do
        expect(tweet).to include word_of_the_day.word.name
      end

      it "includes related words", :focus do
        expect(tweet).to include *%w[bobcat lynx puma leopard tiger]
      end

      it "includes the https protocol" do
        expect(tweet).to include 'https://'
      end
    end
  end
end
