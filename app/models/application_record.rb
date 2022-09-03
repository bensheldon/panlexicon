# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.set_statement_timeout(seconds) # rubocop:disable Naming/AccessorMethodName
    original_timeout = ActiveRecord::Base.connection.execute('SHOW statement_timeout').first['statement_timeout']
    ActiveRecord::Base.connection.execute(sanitize_sql_for_assignment(["SET statement_timeout = ?", "#{seconds.to_i}s"]))
    yield
  ensure
    ActiveRecord::Base.connection.execute(sanitize_sql_for_assignment(["SET statement_timeout = ?", original_timeout])) if original_timeout
  end
end
