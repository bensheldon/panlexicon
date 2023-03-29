# frozen_string_literal: true
require "active_support"
require "active_support/core_ext"

words = Set.new
groups = []

mthesaur = File.read('../mthesaur.txt')
mthesaur_size = mthesaur.split("\n").size

mthesaur.each_line.with_index do |line, index|
  puts("Importing line #{index + 1}/#{mthesaur_size}") if (index % 100).zero?

  group_words = line.split(',')
                .map(&:strip)
                .reject(&:empty?)
                .uniq

  words += group_words
  groups << [group_words.first, group_words]
end

words = words.to_a.sort_by!(&:downcase)
groups.sort_by! { |(keyword, _group_words)| keyword.downcase }

word_data = words.map.with_index(1) do |name, id|
  { id:, name: }
end

words_map = word_data.map { |word| [word[:name], word[:id]] }.to_h

word_groups_data = groups.map do |(keyword, group_words)|
  keyword_id = words_map[keyword]
  word_ids = group_words.map { |group_word| words_map[group_word] }

  { keyword_id:, word_ids: }
end

binding.irb

File.write('../_data/words.json', word_data.to_json)
File.write('../_data/groups.json', word_groups_data.to_json)
