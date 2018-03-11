# frozen_string_literal: true

Capybara.default_max_wait_time = 2

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
        args: %w[no-sandbox headless disable-gpu window-size=1400,900]
      }
    )
    driven_by :selenium, using: :chrome, options: { desired_capabilities: capabilities }
  end

  config.before(:each, type: :system, chrome: true) do |example|
    example.metadata[:js] = true
    driven_by :selenium, using: :chrome, screen_size: [1400, 900]
  end
end
