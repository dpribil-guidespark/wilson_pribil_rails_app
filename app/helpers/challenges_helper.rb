module ChallengesHelper

  def challenge_winners(challenge)
    return challenge.guesses.where(:status => STATUS_RIGHT)
  end

end
