# frozen_string_literal: true

namespace :word_of_the_day do
  desc "Generate the word of the day"
  task generate: [:environment, 'log_level:info'] do |_t, _args|
    WordOfTheDayJob.perform_now
  end
end
