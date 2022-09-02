# frozen_string_literal: true
class SearchRecordsCleanupJob < ApplicationJob
  retry_on StandardError, wait: :exponentially_longer, attempts: 3

  def perform
    helpers = ActionController::Base.helpers

    search_record_count = SearchRecord.lifetime_expired.count

    Rails.logger.info "Cleaning up #{helpers.pluralize(search_record_count, 'search records')} that have expired."

    time_elapsed = Benchmark.realtime do
      SearchRecord.set_statement_timeout(120) do
        SearchRecord.delete_expired
      end
    end

    Rails.logger.info "Cleaned up #{helpers.pluralize(search_record_count, 'expired search records')} in #{helpers.pluralize(time_elapsed.round(2), 'seconds')}."
  end
end
