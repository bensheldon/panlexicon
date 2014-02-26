require 'pathname'

namespace :import do
  desc "Import comma-separated values from Moby Thesaurus"
  task :moby, [:file_path] => :environment do |t, args|
    args.with_defaults :file_path => 'mthesaur.txt'

    filepath = Pathname(args[:file_path])
    if filepath.exist?
      importer = MobyImporter.new(filepath)
      importer.logger.level = Logger::INFO

      importer.import
    else
      abort "Cannot find file: #{filepath.realpath}"
    end
  end
end
