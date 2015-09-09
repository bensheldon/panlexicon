class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :miniprofiler

  # Catch ActionController::RoutingError from route defined in Application.rb
  def render_404
    render status: 404, file: Rails.root.join('public/404.html'), layout: false
  end

  private

  def miniprofiler
    # use /?miniprofiler_key=MINIPROFILER_KEY&pp=flamegraph in production
    return if params.fetch(:miniprofiler_key, nil) != Rails.application.secrets.miniprofiler_key
    Rack::MiniProfiler.authorize_request
  end
end
