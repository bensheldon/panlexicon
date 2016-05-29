class UserSearchRecordsController < ApplicationController
  before_action { authorize :search_record }

  def index
    @search_records = SearchRecordDecorator.decorate_collection \
      SearchRecord.includes(:words).where(user: current_user).order(created_at: :desc)
  end
end
