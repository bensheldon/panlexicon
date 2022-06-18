# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :miniprofiler

  # Catch ActionController::RoutingError from route defined in Application.rb
  def render_404
    render status: :not_found, file: Rails.public_path.join('404.html'), layout: false
  end

  alias devise_current_user current_user
  def current_user
    return @current_user if instance_variable_defined?(:@current_user)

    @current_user = devise_current_user || User.null
  end

  def bot_request?
    return @bot_request if instance_variable_defined?(:@bot_request)

    @bot_request = DeviceDetector.new(request.user_agent).bot?
  end

  def human_request?
    !bot_request?
  end

  private

  def miniprofiler
    Rack::MiniProfiler.authorize_request if current_user.admin?
  end
end
