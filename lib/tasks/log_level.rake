namespace :log_level do
  desc 'Set log level to info and stdout'
  task info: :environment do |t, args|
    Rails.logger = Logger.new(STDOUT)
    Rails.logger.level = 1 # :info
  end
end
