class ApplicationController < ActionController::Base
  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :miniprofiler

  private

  def miniprofiler
    Rack::MiniProfiler.authorize_request if current_user.is_admin?
  end
end
