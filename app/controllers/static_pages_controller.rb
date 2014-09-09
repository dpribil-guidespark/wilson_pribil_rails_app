class StaticPagesController < ApplicationController
  def home
    if Challenge.all.count > 0
      redirect_to 'challenges#latest_challenge'
    end
  end

  def about
  end

  def leaderboard
    @challenge=Challenge.last
    @guesses=Guess.all
    @correct_guesses = @guesses.where(:status => STATUS_RIGHT)
  end
end
