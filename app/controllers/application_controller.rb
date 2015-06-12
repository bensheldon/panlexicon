class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :miniprofiler

  private

  def miniprofiler
    # use /?miniprofiler_key=MINIPROFILER_KEY&pp=flamegraph in production
    if params.fetch(:miniprofiler_key, nil) == Rails.application.secrets.miniprofiler_key
      Rack::MiniProfiler.authorize_request
    end
  end
end
