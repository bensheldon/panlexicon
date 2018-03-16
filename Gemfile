source 'https://rubygems.org'
ruby_version = File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip
ruby ruby_version

gem 'active_null'
gem 'bcrypt'
gem 'bootsnap'
gem 'bootstrap-sass'
gem 'bourbon'
gem 'coffee-rails'
gem 'flamegraph'
gem 'font-awesome-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'memory_profiler'
gem 'pg'
gem 'pry-rails'
gem 'puma'
gem 'pundit'
gem 'rack-mini-profiler', require: false
gem 'rails', '~>5.1.1'
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
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'derailed'
  gem 'guard-livereload', require: false
  gem 'guard-rspec'
  gem 'guard-rubocop', require: false
  gem 'guard-shell', require: false
  gem 'rack-livereload'
  gem 'rails_12factor'
  gem 'rails_layout'
  gem 'rubocop-rspec', require: false
  gem 'slim_lint', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'terminal-notifier-guard', require: false
end
