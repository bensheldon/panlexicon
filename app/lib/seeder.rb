# frozen_string_literal: true

class Seeder
  def word_of_the_days
    (0..10).to_a.each do |i|
      WordOfTheDayGenerator.generate!(date: i.days.ago)
    end
  end

  def users
    User.find_or_initialize_by(email: 'user@example.com') do |user|
      user.password = 'password'
      user.skip_confirmation!
      user.save
    end
  end

  def search_history(total_days = 30)
    datetime = total_days.days.ago

    words = Word.order(Arel.sql("RANDOM()")).limit(total_days * 25)
    raise "No Words" if words.empty?

    loop do
      search_record = SearchRecord.create! created_at: datetime
      search_record.search_records_words.create! [{ word: words.sample, position: 0 }]

      datetime += 1.hour
      break if datetime > Time.current
    end
  end
end
