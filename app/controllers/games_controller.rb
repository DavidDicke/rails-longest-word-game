require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'...'Z').to_a.sample(9)
  end

  def score
    @output = '✅'
    @counter = 0
    @word_suggested = params[:word]
    @letter_set = params[:letters].chars
    @word_suggested.chars.each do |letter|
      @counter += 1 if @letter_set.include?(letter.upcase)
    end
    dict_raw = URI.open("https://dictionary.lewagon.com/#{params[:word]}").read
    dict = JSON.parse(dict_raw)
    unless @counter == @word_suggested.length
      @output = "notIncluded"
    end
    unless dict['found'] == true
      @output = "noEnglish"
    end
  end
end
