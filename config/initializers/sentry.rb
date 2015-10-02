if defined? Raven
  Raven.configure do |config|
    config.environments = %w[ production staging ]
    config.excluded_exceptions = Raven::Configuration::IGNORE_DEFAULT + %w[
      Rack::Timeout::RequestTimeoutError
    ]
  end

  Raven.tags_context({
    'environment' => Rails.env
  })
end
