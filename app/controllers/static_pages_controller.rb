class StaticPagesController < ApplicationController
  def home
    if Challenge.all.count > 0
      redirect_to '/challenges/latest'
    end
  end

  def about
  end

  def leaderboard
    if Challenge.all.count>1
      @challenge=Challenge.all[-2]   
      @guesses=Guess.all
      @correct_guesses = !@guesses.empty? ? @guesses.where(:status => STATUS_RIGHT) : nil
    else
      @challenge = nil
      @guesses = nil
      @correct_guesses = nil
    end
  end
end
