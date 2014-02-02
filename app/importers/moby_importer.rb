class MobyImporter
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def import
    file.each_line do |line|
      import_string line
    end
  end

  def import_string(string)
    terms = string.split(',').map{ |name| Term.find_or_create_by(name: name) }
    return unless terms.size > 0

    key_term = terms[0]

    group = Group.new key_term: key_term
    group.terms += terms

    puts "ERROR #{group.errors.full_messages}: #{string}" unless group.save
  end
end
