# frozen_string_literal: true

namespace :db do
  namespace :seed do
    require_relative(Rails.root.join("app/lib/seeder.rb"))
    seeder = Seeder.new

    seeder_methods = seeder.methods - Object.methods
    seeder_methods.each do |task_name|
      desc "Seed #{task_name}, based on Seeder##{task_name}"
      task task_name.to_sym => :environment do
        seeder.public_send(task_name)
      end
    end
  end
end
