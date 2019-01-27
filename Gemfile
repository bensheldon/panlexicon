# frozen_string_literal: true

source 'https://rubygems.org'
ruby_version = File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip
ruby ruby_version

gem 'active_null'
gem 'bcrypt'
gem 'bootsnap'
gem 'bootstrap-sass'
gem 'bourbon'
gem 'coffee-rails'
gem 'device_detector'
gem 'devise'
gem 'flamegraph'
gem 'font-awesome-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'memory_profiler'
gem 'pg'
gem 'pry-rails'
gem 'puma'
gem 'pundit'
gem 'rack-host-redirect'
gem 'rack-mini-profiler', require: false
gem 'rails', '~>5.2.1'
gem 'redcarpet'
gem 'redis'
gem 'sass-rails'
gem 'slim-rails'
gem 'stackprof', require: false
gem 'twitter'
gem 'uglifier'

group :production, :staging do
  gem 'heroku-deflater'
  gem 'lograge'
  gem 'newrelic_rpm'
  gem 'rack-timeout' # https://github.com/heroku/rack-timeout/issues/55
  gem 'sentry-raven'
end

group :test do
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'timecop'
  gem 'webmock'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'derailed'
  gem 'listen'
  gem 'rails_layout'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'slim_lint', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'
end
