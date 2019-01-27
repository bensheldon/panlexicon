# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WordOfTheDayTweet do
  use_moby_cats

  let(:word_of_the_day) { WordOfTheDay.create word: Word.find_by(name: 'lion') }
  let(:tweeter) { described_class.new word_of_the_day }
  let(:twitter_client) { instance_double(Twitter::REST::Client, update: nil) }

  before do
    allow(Twitter::REST::Client).to receive(:new).and_return(twitter_client)
  end

  describe '#generate!' do
    it 'invokes twitter_client#update' do
      tweeter.generate!
      expect(twitter_client).to have_received(:update)
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
        expect(tweet).to include('bobcat', 'lynx', 'puma', 'leopard', 'tiger')
      end

      it 'includes link to the website' do
        link = tweet.split.last
        expect(link).to match URI.regexp %w(http https)
      end
    end
  end
end
