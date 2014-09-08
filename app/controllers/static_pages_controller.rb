class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def leaderboard
    @challenge=Challenge.last
    @guesses=Guess.all
    @correct_guesses = @guesses.where(:status => STATUS_RIGHT)
  end
end
