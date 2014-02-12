class MobyImporter
  attr_reader :file

  def initialize(file, options={})
    @file = file
    @options = {
      print_log: true
    }.merge(options)

  end

  def import
    file.each_line do |line|
      import_string line
    end
  end

  def import_string(string)
    ActiveRecord::Base.transaction do
      words = string.split(',').map{ |name| Word.find_or_create_by(name: name.strip) }
      return unless words.size > 0

      key_word = words[0]

      group = Group.find_or_create_by(key_word: key_word)
      group.words += words

      log "ERROR #{group.errors.full_messages}: #{string}" unless group.save
    end
  end

  def log(message)
    puts message if @options[:print_log]
  end
end
