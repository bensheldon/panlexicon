# frozen_string_literal: true

require 'benchmark'

namespace :search_records do
  desc "Clean up old/expired search records"
  task cleanup: [:environment, 'log_level:info'] do |_t, _args|
    SearchRecordsCleanupJob.perform_now
  end
end
