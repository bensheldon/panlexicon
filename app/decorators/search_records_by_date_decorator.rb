class SearchRecordsByDateDecorator < ApplicationDecorator
  alias :search :object
  delegate :url_helpers, to: 'Rails.application.routes'

  def results
    WordDecorator.decorate_collection search.results
  end

  def next_day_path
    today = Time.now.utc.to_date
    next_date = search.date + 1
    if next_date <= today
      url_helpers.history_path datestring: next_date.strftime(HistoryController::DATE_FORMAT)
    else
      nil
    end
  end

  def previous_day_path
    today = Time.now.utc.to_date
    prev_date = search.date - 1
    if prev_date < today
      url_helpers.history_path datestring: prev_date.strftime(HistoryController::DATE_FORMAT)
    else
      url_helpers.history_path datestring: today.strftime(HistoryController::DATE_FORMAT)
    end
  end
end
