# == Schema Information
#
# Table name: parts_of_speech
#
#  id      :integer          not null, primary key
#  word_id :integer
#  type    :string
#
# Indexes
#
#  index_parts_of_speech_on_word_id           (word_id)
#  index_parts_of_speech_on_word_id_and_type  (word_id,type)
#

class PartOfSpeech < ApplicationRecord
  TYPE_MAP = {
    noun: 'N',
    plural: 'p',
    noun_phrase: 'h',
    verb_participle: 'V',
    verb_transitive: 't',
    verb_intransitive: 'i',
    adjective: 'A',
    adverb: 'v',
    conjunction: 'C',
    preposition: 'P',
    interjection: '!',
    pronoun: 'r',
    definite_article: 'D',
    indefinite_article: 'I',
    nominative: 'o'
  }.freeze
  CODE_MAP = TYPE_MAP.invert.freeze

  belongs_to :word
  enum type: TYPE_MAP
  set_inheritance_column :sti_type
  validates :type, inclusion: { in: CODE_MAP.keys }
end
