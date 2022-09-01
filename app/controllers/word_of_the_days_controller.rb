# frozen_string_literal: true

class WordOfTheDaysController < ApplicationController
  def index
    @word_of_the_days = WordOfTheDay.order(date: :desc)
  end
end
