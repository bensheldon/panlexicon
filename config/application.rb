require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Panlexicon
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be loaded
    # http://blog.arkency.com/2014/11/dont-forget-about-eager-load-when-extending-autoload/
    paths.add 'app/decorators/collections', eager_load: true
    paths.add 'lib', glob: '*', eager_load: true

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # 404 catch all route
    # https://github.com/rails/rails/issues/671#issuecomment-1780159
    config.after_initialize do |app|
      app.routes.append { match '*path', via: [:get, :post], to: 'application#render_404' } unless config.consider_all_requests_local
    end

    default_url_options = {
      protocol: 'https',
      host: Rails.application.secrets.hostname
    }
    Rails.application.routes.default_url_options = default_url_options
    config.action_mailer.default_url_options = default_url_options
  end
end
