# frozen_string_literal: true

require 'pathname'

namespace :moby do
  desc "Import comma-separated values from Moby Thesaurus"
  task :import_thesaurus, [:file_path] => [:environment, 'log_level:info'] do |_t, args|
    args.with_defaults file_path: 'mthesaur.txt'

    filepath = Pathname(args[:file_path])
    abort "Cannot find file: #{filepath.realpath}" unless filepath.exist?

    importer = MobyImporter.new
    importer.thesaurus(filepath)
  end

  task :import_parts_of_speech, [:file_path] => :environment do |_t, args|
    args.with_defaults file_path: 'mobypos.txt'

    filepath = Pathname(args[:file_path])
    abort "Cannot find file: #{filepath.realpath}" unless filepath.exist?

    importer = MobyImporter.new
    importer.parts_of_speech(filepath)
  end

  desc "Download cached Thesaurus data"
  task thesaurus_db: [:environment, 'log_level:info'] do |_t, _args|
    require 'open-uri'

    open('data.sql.tar', 'wb') do |file|
      file << open('https://github.com/bensheldon/panlexicon-rails/releases/download/v1/data.sql.tar').read
    end

    if ENV['RAILS_ENV'] == 'staging'
      system <<~BASH
        pg_restore --verbose --data-only --no-acl --no-owner \
          -d $DATABASE_URL \
          data.sql.tar
      BASH
    else
      system <<~BASH
        pg_restore --verbose --data-only --no-acl --no-owner \
          -U ${PGUSER:-$(whoami)} -d panlexicon_#{ENV.fetch('RAILS_ENV', 'development')} \
          data.sql.tar
      BASH
    end
  end
end
