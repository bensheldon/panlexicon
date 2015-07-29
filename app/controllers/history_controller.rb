class HistoryController < ApplicationController
  DATE_FORMAT = '%Y-%m-%d'

  def index
    datestring = params.fetch('datestring') { Time.now.utc.to_date.strftime DATE_FORMAT }
    date = Date.strptime datestring, DATE_FORMAT

    records = SearchRecordsByDate.new date
    @records = SearchRecordsByDateDecorator.new records
  end
end
