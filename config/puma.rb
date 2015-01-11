DEFAULT_PUMA_WORKERS = 3
DEFAULT_MIN_THREADS = 1
DEFAULT_MAX_THREADS = 16

workers Integer(ENV['PUMA_WORKERS'] || DEFAULT_PUMA_WORKERS)
threads Integer(ENV['MIN_THREADS']  || DEFAULT_MIN_THREADS), Integer(ENV['MAX_THREADS'] || DEFAULT_MAX_THREADS)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] || Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || DEFAULT_MAX_THREADS
    ActiveRecord::Base.establish_connection(config)
  end
end
