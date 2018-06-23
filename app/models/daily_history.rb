class DailyHistory
  include ActiveModel::Model
  HISTORY_SQL = File.read Rails.root.join('app/models/sql/search_history.sql')

  attr_accessor :date, :words

  def self.all
    words = Word.find_by_sql [HISTORY_SQL]

    words.group_by(&:date).map do |date, words|
      new(date: date, words: words)
    end
  end
end
