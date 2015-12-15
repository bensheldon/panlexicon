class SearchParser
  attr_reader :string, :fragments

  def initialize(string)
    @string = string

    @fragments = split_string.map.with_index do |string_fragment, position|
      OpenStruct.new string: string_fragment, position: position
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
    Word.where(name: fragments.map(&:string)).find_each do |word|
      fragment = fragments.find { |f| f.string.downcase == word.name.downcase }
      fragment.word = word
    end
  end
end
