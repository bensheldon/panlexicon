class MobyImporter
  attr_reader :file, :logger

  def thesaurus(file)
    Rails.logger.info("Beginning import of #{file}")
    total_lines = file.readlines.size

    file.each_line.with_index do |line, i|
      Rails.logger.info("Importing line #{i + 1}/#{total_lines}") if i % 25 == 0
      thesaurus_string line
    end
  end

  def parts_of_speech(file)
    Rails.logger.info("Beginning import of #{file}")
    total_lines = file.readlines.size

    file.each_line.with_index do |line, i|
      Rails.logger.info("Importing line #{i + 1}/#{total_lines}") if i % 25 == 0
      word_string, _slash, part_codes = line.strip.partition('\\')

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
                    .reject { |name| name.strip.empty? }
                    .map { |name| Word.find_or_create_by(name: name.strip) }
      return unless words.size > 0

      # First word in the group is the keyword
      key_word = words[0]

      group = Group.find_or_create_by(key_word: key_word)
      group.words += words.uniq

      Rails.logger.error("#{group.errors.full_messages}: #{string}") unless group.save
    end
  end
end
