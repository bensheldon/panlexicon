class SearchRecordDecorator < ApplicationDecorator
  alias :search_record :object

  def to_s
    search_record.search_records_words.map do |search_records_word|
      if search_records_word.operation == 'subtract'
        "-#{search_records_word.word.name}"
      else
        search_records_word.word.name
      end
    end.join(', ')
  end
end
