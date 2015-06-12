require 'rack-mini-profiler'

Rack::MiniProfilerRails.initialize!(Rails.application)

# heroku-deflater gem inserts Rack::Deflater
# We need to mount Rack::MiniProfiler after that
if defined? HerokuDeflater
  Rails.application.middleware.delete(Rack::MiniProfiler)
  Rails.application.middleware.insert_after(Rack::Deflater, Rack::MiniProfiler)
end
