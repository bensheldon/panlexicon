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
      subject(:tweet) do
        tweet = nil
        allow(twitter_client).to receive(:update) do |msg|
          tweet = msg
        end
        tweeter.generate!
        tweet
      end

      it 'is correctly formatted' do
        expect(tweet).to start_with <<~TWEET.strip
          LION is today's word. Related to tiger, leopard, cat, Siamese, bobcat, Maine Coon, lynx, & puma.
        TWEET
      end

      it 'includes link to the website' do
        link = tweet.split.last
        expect(link).to match URI::DEFAULT_PARSER.make_regexp(%w(http https))
      end
    end
  end
end
