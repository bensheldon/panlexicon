# frozen_string_literal: true

namespace :log_level do
  desc 'Set log level to info and stdout'
  task info: :environment do |_t, _args|
    Rails.logger = Logger.new($stdout)
    Rails.logger.level = 1 # :info
  end
end
