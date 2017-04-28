if defined? Raven
  Raven.configure do |config|
    config.environments = %w[ production staging ]
    config.excluded_exceptions = Raven::Configuration::IGNORE_DEFAULT + %w[
      Rack::Timeout::RequestTimeoutError
    ]
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  end
end
