# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.find_or_initialize_by(email: 'user@example.com') do |user|
  user.password = 'password'
  user.skip_confirmation!
  user.save
end

word_ids = (0..Word.count).to_a
datetime = 30.days.ago
loop do
  $stdout.puts "Seeding clicks for #{datetime}"
  search_record = SearchRecord.create! created_at: datetime
  search_record.search_records_words.create! [{ word_id: word_ids.sample, position: 0 }]

  datetime += 1.hour
  break if datetime > Time.current
end
