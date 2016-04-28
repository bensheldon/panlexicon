require 'benchmark'

namespace :search_records do
  desc "Clean up old/expired search records"
  task cleanup: [:environment, 'log_level:info'] do |t, args|
    helpers = ActionController::Base.helpers

    search_record_count = SearchRecord.lifetime_expired.count

    Rails.logger.info "Cleaning up #{helpers.pluralize(search_record_count, 'search records')} that have expired."

    time_elapsed = Benchmark.realtime do
      SearchRecord.delete_expired
    end

    Rails.logger.info "Cleaned up #{helpers.pluralize(search_record_count, 'expired search records')} in #{helpers.pluralize(time_elapsed.round(2), 'seconds')}."
  end
end
