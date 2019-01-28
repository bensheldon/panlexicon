# frozen_string_literal: true

class SearchRecordPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
