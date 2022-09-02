# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.set_statement_timeout(seconds)
    original_timeout = ActiveRecord::Base.connection.execute('SHOW statement_timeout').first['statement_timeout']
    ActiveRecord::Base.connection.execute("SET statement_timeout = '#{seconds.to_i}s'")
    yield
  ensure
    ActiveRecord::Base.connection.execute("SET statement_timeout = #{original_timeout}") if original_timeout
  end
end
