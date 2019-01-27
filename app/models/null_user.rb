# frozen_string_literal: true

NullUser = Naught.build do |config|
  config.predicates_return false
  config.black_hole
  config.singleton

  def id
    nil
  end
end
