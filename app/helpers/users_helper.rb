module UsersHelper

  def number_of_guesses(user)
    return user.guesses.count
  end

  def number_of_wins(user)
    return user.guesses.where(:status => STATUS_RIGHT).count
  end

end
