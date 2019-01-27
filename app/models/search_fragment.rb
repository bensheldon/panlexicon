# frozen_string_literal: true

class SearchFragment
  include ActiveModel::Model
  attr_accessor :string, :word_string, :operation_string, :position, :word, :operation

  validates :operation, presence: true, inclusion: { in: [:add, :subtract] }
end
