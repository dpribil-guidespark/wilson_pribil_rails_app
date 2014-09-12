class StaticPagesController < ApplicationController
  before_action :set_entities

  def home
    if Challenge.all.count > 0
      redirect_to challenge_path
    end
  end

  def about
  end

  def leaderboard
  end

  private
  def set_entities
    @challenge= Challenge.all[-1]
    if Challenge.all.count>1
      @guesses=Guess.all
      @correct_guesses = !@guesses.empty? ? @guesses.where(:status => STATUS_RIGHT) : nil
    end
  end
end
