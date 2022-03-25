# frozen_string_literal: true

class SearchParser
  attr_reader :string, :fragments, :part_of_speech

  def initialize(string)
    @string = string

    @fragments = split_string.map.with_index do |string_fragment, position|
      matches = string_fragment.match(/(?<pos>pos:\S*)?\s*(?<operation_string>[+-]?)(?<word_string>.*(?=pos:)|.*)\s*(?<pos>pos:\S*)?/)

      @part_of_speech = matches['pos'].split(':').last if matches['pos']

      word_string = matches['word_string'].strip
      next unless word_string

      operation_string = matches['operation_string'].presence

      operation = if operation_string == '-'
                    :subtract
                  else
                    :add
                  end

      SearchFragment.new string: string_fragment,
                         operation_string: operation_string,
                         word_string: word_string,
                         position: position,
                         operation: operation
    end
  end

  def execute
    attach_words_to_fragments
  end

  def words
    fragments.select { |fragment| fragment.word.present? }.map(&:word)
  end

  def missing_words
    fragments.reject { |fragment| fragment.word.present? }.map(&:string)
  end

  private

  def split_string
    string.split(',').map(&:strip)
  end

  def attach_words_to_fragments
    Word.where(name: fragments.map(&:word_string)).find_each do |word|
      fragment = fragments.find { |f| f.word_string.casecmp(word.name).zero? }
      fragment.word = word
    end
  end
end
