module ChallengesHelper

  def challenge_winners(challenge)
    if challenge
      winners = challenge.guesses.where(:status => STATUS_RIGHT) 
    else
      winners = nil
    end
  end

end
