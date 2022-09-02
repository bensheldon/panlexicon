# frozen_string_literal: true
class WordOfTheDayJob < ApplicationJob
  retry_on StandardError, wait: :exponentially_longer, attempts: 3

  def perform
    word_of_the_day = WordOfTheDayGenerator.generate!
    Rails.logger.info "Generated Word of the Day: #{word_of_the_day.word.name}"

    tweet = WordOfTheDayTweet.generate! word_of_the_day
    Rails.logger.info "Posted to Twitter [#{tweet.url}]: #{tweet.text}"
  end
end
