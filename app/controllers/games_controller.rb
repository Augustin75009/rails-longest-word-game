require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    proposal = params['list_letters'].split(//)

    url = "https://wagon-dictionary.herokuapp.com/#{params["list_letters"]}"
    reading = open(url).read
    exist = JSON.parse(reading)

    letters = params[:letters]
    word = params['list_letters']

    contain = true
    proposal.each do |letter|
      unless letters.include?(letter)
        contain = false
        @score = "sorry this word can't be build"
      end
    end

    if contain
      if exist['found']
        @score = "#{exist['found']} - your score is : #{exist['length']}"
      else
        @score = "sorry the #{word} don't exist"
      end
    end
  end
end
