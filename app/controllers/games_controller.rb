require "json"
require 'open-uri'


class GamesController < ApplicationController

  def new
    @letters = [*'A'..'Z'].sample(10)
  end

  def score
    word_letters = params[:word].upcase.split('')
    grid_letters = params[:letters].split(' ')

    if word_letters.all? { |letter| grid_letters.include?(letter) }
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      word_serialized = URI.open(url).read
      word = JSON.parse(word_serialized)
      if word["found"]
        @message = "The word is valid according to the grid and is an English word"
      else
        @message = "The word is valid according to the grid, but is not a valid English word"
      end
    else
      @message = "The word can’t be built out of the original grid"
    end
  end
end
