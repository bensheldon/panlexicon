class SearchParser
  attr_reader :string, :fragments

  def initialize(string)
    @string = string

    @fragments = split_string.map.with_index do |string_fragment, position|
      matches = string_fragment.match( /(?<pos>pos:\S*)?\s*(?<operation_string>[+-]?)(?<word_string>\S*)\s*(?<pos>pos:\S*)?/)

      if matches['pos']
        @part_of_speech = matches['pos'].split(':').last
      end

      word_string = matches['word_string'].strip
      next unless word_string

      operation_string = if matches['operation_string'].present?
        matches['operation_string']
      else
        nil
      end

      if operation_string == '-'
        operation = :subtract
      else
        operation = :add
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

  def part_of_speech
    @part_of_speech
  end

  private

  def split_string
    string.split(',').map(&:strip)
  end

  def attach_words_to_fragments
    Word.where(name: fragments.map(&:word_string)).find_each do |word|
      fragment = fragments.find { |f| f.word_string.downcase == word.name.downcase }
      fragment.word = word
    end
  end
end
