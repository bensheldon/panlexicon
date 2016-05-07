if ENV.key? 'TRAVIS'
  require 'coveralls'
  Coveralls.wear!('rails')
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
ENV['RACK_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'factory_girl'
require 'capybara/rspec'
require 'capybara/poltergeist'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.extend(MobyMacros)

  config.include SearchSteps, type: :feature
  config.include Features::SessionHelpers, type: :feature

  unless ENV['CI']
    config.run_all_when_everything_filtered = true
    config.filter_run focus: true
  end

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.before(:suite) do
    FactoryGirl.reload
  end

  # rspec-rails 3 will no longer automatically infer an example
  # group's spec type from the file location.
  config.infer_spec_type_from_file_location!

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Using DatabaseCleaner (see support configuration)
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # Allow local connections for Poltergeist; disable for Sauce Labs
  WebMock.disable_net_connect! allow_localhost: true

  Capybara.default_max_wait_time = 2
  poltergist_timeout = 30

  # Configure Poltergeist
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, timeout: poltergist_timeout.seconds)
  end

  # For debugging call `page.driver.debug` to open a browser
  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new(app, timeout: poltergist_timeout.seconds, inspector: true)
  end

  Capybara.javascript_driver = :poltergeist_debug
end
