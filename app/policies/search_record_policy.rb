class SearchRecordPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
