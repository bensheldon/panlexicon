require 'bundler/setup'
require 'capybara/rspec'
require 'capybara/cuprite'
require 'lanyon'
require 'webrick'

RSpec.configure do |config|
  config.include Capybara::DSL

  Capybara.register_driver(:cuprite) do |app|
    Capybara::Cuprite::Driver.new(app, window_size: [1200, 800], inspector: ENV['INSPECTOR'])
  end

  skip_build = ['1', 'true', 'True'].include? ENV.fetch('JEKYLL_SKIP_BUILD', '0')

  Capybara.server = :webrick
  Capybara.default_driver = :rack_test
  Capybara.javascript_driver = :cuprite
  Capybara.app = Lanyon.application(skip_build: skip_build, baseurl: '')
end
