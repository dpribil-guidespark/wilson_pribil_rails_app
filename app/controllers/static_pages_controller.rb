class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def leaderboard
    @challenge=Challenge.last
  end
end
