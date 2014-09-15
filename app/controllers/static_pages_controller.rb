class StaticPagesController < ApplicationController
  before_action :set_entities

  def gotw_home
    if Challenge.all.count > 0
      redirect_to geek_of_the_week_path
    end
  end

  def gotw_about
    render 'about'
  end

  def rotw_home
    if Req.all.count > 0
      redirect_to req_of_the_week_path
    end
  end

  def rotw_about
    render 'about'
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
