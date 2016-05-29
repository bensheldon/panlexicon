class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper

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
    Rack::MiniProfiler.authorize_request if current_user.is_admin?
  end
end
