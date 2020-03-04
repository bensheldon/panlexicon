# frozen_string_literal: true

Capybara.default_max_wait_time = 2
Capybara.server = :puma, { Silent: true }

RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    if ENV['SHOW_BROWSER']
      example.metadata[:js] = true
      driven_by :cuprite, window_size: [1024, 800]
    else
      driven_by :rack_test
    end
  end

  config.before(:each, type: :system, js: true) do
    driven_by :cuprite #, window_size: [1024, 800], headless: ENV['SHOW_BROWSER']
  end
end
