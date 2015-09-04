namespace :word_of_the_day do
  desc "Generate the word of the day"
  task :generate => :environment do |t, args|
    Rails.logger = Logger.new(STDOUT)
    Rails.logger.level = 1 # :info

    word_of_the_day = WordOfTheDayGenerator.generate!
    Rails.logger.info "Generated Word of the Day: #{word_of_the_day.word.name}"

    tweet = WordOfTheDayTweet.generate! word_of_the_day
    Rails.logger.info """Posted to Twitter [#{tweet.url}]: #{tweet.text}"""
  end
end
