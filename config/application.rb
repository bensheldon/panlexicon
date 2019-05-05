require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Panlexicon
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be loaded
    # http://blog.arkency.com/2014/11/dont-forget-about-eager-load-when-extending-autoload/
    paths.add 'app/decorators/collections', eager_load: true
    config.watchable_dirs['app/models/sql'] = [:sql, :erb]

    config.action_mailer.default_url_options = {
      host: Rails.application.secrets.hostname
    }
  end
end
