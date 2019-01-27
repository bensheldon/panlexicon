# frozen_string_literal: true

# == Schema Information
#
# Table name: parts_of_speech
#
#  id        :bigint(8)        not null, primary key
#  word_id   :bigint(8)        not null
#  type_code :string(1)        not null
#
# Indexes
#
#  index_parts_of_speech_on_word_id                (word_id)
#  index_parts_of_speech_on_word_id_and_type_code  (word_id,type_code) UNIQUE
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
    nominative: 'o',
  }.freeze

  CODE_MAP = TYPE_MAP.invert.freeze

  self.inheritance_column = :sti_type

  belongs_to :word, counter_cache: :parts_of_speech_count
  validates :type_code, inclusion: { in: TYPE_MAP.values }
end
