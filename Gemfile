source 'https://rubygems.org'
ruby File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip

gem 'rails', '5.0.0.rc1'
gem 'puma'

# Databases
gem 'pg'

gem 'skylight', '1.0.0.beta4' #Rails 5

gem 'slim-rails'
gem 'redcarpet'

# Use SCSS for stylesheets
gem 'sass-rails'
gem 'bourbon'
gem 'bootstrap-sass'
gem 'font-awesome-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'twitter'

# Use ActiveModel has_secure_password
gem 'bcrypt'
gem 'has_secure_token'
gem 'active_null'
gem 'pundit'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Profiling
gem 'rack-mini-profiler', require: false
gem 'flamegraph'
gem 'memory_profiler'
gem 'stackprof', require: false

gem 'pry-rails'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'terminal-notifier-guard', require: false

  gem 'rack-livereload'
  gem 'guard-rspec', '4.6.5'
  gem 'guard-livereload', require: false
  gem 'guard-rubocop', require: false
  gem 'guard-shell', require: false

  gem 'rubocop-rspec', require: false
  gem 'slim_lint', require: false

  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'derailed'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request' # for use with RailsPanel Chrome Extension
  gem 'quiet_assets'

  gem 'annotate'
  gem 'rails_layout'
end

group :development, :test do
  gem 'rspec', '3.5.0.beta3'
  gem 'rspec-rails', '3.5.0.beta3'
  gem 'rails-controller-testing'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'launchy'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'webmock'
  gem 'timecop'

  gem 'simplecov'
  gem 'coveralls', require: false
end

group :production do
  gem 'rails_12factor'
  gem 'heroku-deflater'

  # https://github.com/heroku/rack-timeout/issues/55
  gem 'rack-timeout'

  # Instrumentation
  gem 'sentry-raven'
  gem 'lograge'
  gem 'newrelic_rpm'
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
