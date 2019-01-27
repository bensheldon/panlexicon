# frozen_string_literal: true

class DailyHistoriesController < ApplicationController
  before_action(if: :account_history?) { authorize :search_record }

  def index
    user = account_history? ? current_user : nil
    @daily_histories = DailyHistory.all(user: user)
  end

  private

  def account_history?
    params[:account].present?
  end
end
