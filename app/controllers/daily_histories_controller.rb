class DailyHistoriesController < ApplicationController
  def index
    @daily_histories = DailyHistory.all
  end
end
