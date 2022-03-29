# frozen_string_literal: true

class MobyImporter
  attr_reader :file, :logger

  def thesaurus(file)
    Rails.logger.info("Beginning import of #{file}")
    total_lines = file.readlines.size

    file.each_line.with_index do |line, i|
      Rails.logger.info("Importing line #{i + 1}/#{total_lines}") if (i % 25).zero?
      thesaurus_string line
    end
  end

  def parts_of_speech(file)
    Rails.logger.info("Beginning import of #{file}")
    total_lines = file.readlines.size

    file.each_line.with_index do |line, i|
      Rails.logger.info("Importing line #{i + 1}/#{total_lines}") if (i % 25).zero?
      clean_line = line.force_encoding(Encoding::UTF_8).strip
      word_string, _slash, part_codes = clean_line.partition('\\')

      ActiveRecord::Base.transaction do
        word = Word.find_by name: word_string.strip
        next if word.blank?

        part_codes.chars.each do |part_code|
          word.parts_of_speech.find_or_create_by! type_code: part_code
        end
      end
    end
  end

  private

  def thesaurus_string(string)
    ActiveRecord::Base.transaction do
      words = string.split(',')
                    .map(&:strip)
                    .reject(&:empty?)
                    .uniq
                    .map { |name| Word.find_or_create_by(name: name) }
      raise ActiveRecord::Rollback if words.size.zero?

      key_word = words.first
      group = Group.find_or_create_by(key_word: key_word)

      words.each do |word|
        next if group.words.include?(word)

        group.words << word
      end

      Rails.logger.error("#{group.errors.full_messages}: #{string}") unless group.save
    end
  end
end
