source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.1'
gem 'puma'

# https://github.com/heroku/rack-timeout/issues/55
gem 'rack-timeout', group:  [:production, :development]

# Databases
gem 'pg'

gem 'skylight'

gem 'haml'
gem 'haml-rails'
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

gem 'draper'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'terminal-notifier-guard', require: false

  gem 'rack-livereload'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'guard-rubocop', require: false

  gem 'spring'
  gem 'spring-commands-rspec'


  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request' # for use with RailsPanel Chrome Extension
  gem 'quiet_assets'

  gem 'annotate'
  gem 'rails_layout'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
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

  # Instrumentation
  gem 'sentry-raven'
  gem 'lograge'
  gem 'newrelic_rpm'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
