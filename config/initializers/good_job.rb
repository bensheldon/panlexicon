Rails.application.configure do
  if Rails.env.production?
    config.good_job.execution_mode = :async
    config.good_job.poll_interval = 30

    config.good_job.cron = {
      search_records_cleanup: {
        cron: '0 * * * *', # every hour on the 30min
        class: 'SearchRecordsCleanupJob',
        description: "Clean up old Search Records",
      },
      word_of_the_day: {
        cron: '0 16 * * *', # 1600 UTC
        class: 'WordOfTheDayJob',
        description: "Create and tweet Word of the Day",
      }
    }

    GoodJob::Engine.middleware.use(Rack::Auth::Basic) do |username, password|
      ENV['GOOD_JOB_PASSWORD'].present? &&
        ActiveSupport::SecurityUtils.secure_compare("goodjob", username) &&
        ActiveSupport::SecurityUtils.secure_compare(ENV['GOOD_JOB_PASSWORD'], password)
    end
  end
end
