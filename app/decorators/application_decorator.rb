# frozen_string_literal: true

# https://robots.thoughtbot.com/evaluating-alternative-decorator-implementations-in
class ApplicationDecorator < SimpleDelegator
  attr_reader :context

  def self.decorate_collection(collection, context = {})
    collection.map { |object| new(object, context) }
  end

  def initialize(object, context = {})
    super(object)
    @context = context
  end

  delegate :class, to: :object

  def object
    __getobj__
  end
end
