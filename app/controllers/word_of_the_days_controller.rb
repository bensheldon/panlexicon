# frozen_string_literal: true

class WordOfTheDaysController < ApplicationController
  def index
    @word_of_the_days = WordOfTheDay.includes(:word).order(date: :desc)
  end
end
