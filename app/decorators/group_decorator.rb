class GroupDecorator < Draper::Decorator
  delegate_all

  decorates_association :key_word, with: WordDecorator

  def search
    context[:search]
  end
end
