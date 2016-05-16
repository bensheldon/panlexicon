require 'rack-mini-profiler'

Rack::MiniProfilerRails.initialize!(Rails.application)

# heroku-deflater gem inserts Rack::Deflater
# We need to mount Rack::MiniProfiler after that
if defined? HerokuDeflater
  # https://github.com/MiniProfiler/rack-mini-profiler/issues/242
  Rails.application.middleware.swap(Rack::Deflater, Rack::MiniProfiler)
  Rails.application.middleware.swap(Rack::MiniProfiler, Rack::Deflater)
end
