class WordOfTheDayTweet
  MAX_SIZE = 130
  URL_SIZE = 28 # hardcoded rather than fetched dynamically from twitter

  attr_reader :word_of_the_day
  delegate :url_helpers, to: 'Rails.application.routes'

  def self.generate!(word_of_the_day)
    new(word_of_the_day).generate!
  end

  def initialize(word_of_the_day)
    @word_of_the_day = word_of_the_day
  end

  def generate!
    twitter_client.update sentence
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_oauth_token
      config.access_token_secret = Rails.application.secrets.twitter_oauth_secret
    end
  end

  def sentence
    introduction = "#{word_of_the_day.word.name.upcase} is today's word. Related to"

    search = Search.new word_of_the_day.word.name
    search.execute
    related_words = search.results
                          .reject { |word| word.name == word_of_the_day.word.name }
                          .shuffle random: Random.new(1) # for repeatable result

    fitted_names = related_words.map(&:name).each_with_object([]) do |name, names|
      proposed_sentence = "#{introduction} #{anded_list(names + [name])}. "
      names.push(name) if (proposed_sentence.size + URL_SIZE) < MAX_SIZE
    end

    url = url_helpers.search_url q: word_of_the_day.word.name
    "#{introduction} #{anded_list(fitted_names)}. #{url}"
  end

  def anded_list(list)
    list.to_sentence words_connector: ', ', two_words_connector: ' & ', last_word_connector: ', & '
  end
end
