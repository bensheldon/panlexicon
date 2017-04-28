source 'https://rubygems.org'
ruby_version = File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip
ruby ruby_version

gem 'rails', '5.0.2'
gem 'puma'

# Databases
gem 'pg'

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
gem 'active_null'
gem 'pundit'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Profiling
gem 'rack-mini-profiler', require: false
gem 'redis'
gem 'flamegraph'
gem 'memory_profiler'
gem 'stackprof', require: false

gem 'pry-rails'

group :development do
  gem 'terminal-notifier-guard', require: false

  gem 'rack-livereload'
  gem 'guard-rspec'
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

  gem 'annotate'
  gem 'rails_layout'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
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
