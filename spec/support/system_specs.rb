# frozen_string_literal: true

Capybara.default_max_wait_time = 2
Capybara.server = :puma, { Silent: true }

RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    if ENV['SHOW_BROWSER']
      example.metadata[:js] = true
      driven_by :selenium, using: :chrome, screen_size: [1024, 800]
    else
      driven_by :rack_test
    end
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium, using: (ENV['SHOW_BROWSER'] ? :chrome : :headless_chrome), screen_size: [1024, 800] do |options|
      # Chrome's no-sandbox option is required for running in Docker
      %w[
        no-sandbox
        disable-dev-shm-usage
      ].each do |arg|
        options.add_argument(arg)
      end
    end
  end
end
