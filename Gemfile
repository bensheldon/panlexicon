source 'https://rubygems.org'
ruby "2.1.1"

gem 'rails', '4.1.1'
gem 'thin'

# Databases
gem 'pg'

gem 'haml-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bourbon', '~> 3.2.3'
gem 'bootstrap-sass'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Pull Draper from `master` because of rspec 3 deprecation warnings
# https://github.com/drapergem/draper/pull/623
gem 'draper', :git => 'git://github.com/drapergem/draper.git'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard', require: false
  gem 'rb-fsevent'

  gem 'rack-livereload'
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

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
