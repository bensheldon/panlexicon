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

  desc "Download cached Thesaurus data"
  task thesaurus_db: :environment do |t, args|
    require 'open-uri'

    open('data.sql.tar', 'wb') do |file|
      file << open('https://github.com/bensheldon/panlexicon-rails/releases/download/v1/data.sql.tar').read
    end

    if ENV['RAILS_ENV'] == 'staging'
      system "
        pg_restore --verbose --data-only --no-acl --no-owner \
          -d $DATABASE_URL \
          data.sql.tar
      "
    else
      system "
        pg_restore --verbose --data-only --no-acl --no-owner \
          -h localhost -U $(whoami) -d panlexicon_#{ENV.fetch('RAILS_ENV', 'development')} \
          data.sql.tar
      "
    end
  end
end
