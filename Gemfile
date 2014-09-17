source 'https://rubygems.org'
ruby "2.1.1"

gem 'rails', '4.1.4'
gem 'thin'

# Databases
gem 'pg'

gem 'haml-rails'
gem 'redcarpet'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bourbon', '~> 3.2.3'
gem 'bootstrap-sass'
gem 'font-awesome-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'draper', '~> 1.3.1'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.1.1'

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

  gem 'pry-rails'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request' # for use with RailsPanel Chrome Extension
  gem 'quiet_assets'

  gem 'annotate'
  gem 'rails_layout'
end

group :development, :test do
  gem 'rspec-rails', "~> 3.0.0"
  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'webmock'
  gem 'shoulda-matchers'
  gem 'timecop'

  gem 'simplecov', '0.7.1' # see https://github.com/colszowka/simplecov/issues/281
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
