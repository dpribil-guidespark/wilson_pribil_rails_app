module ChallengesHelper

  def challenge_winners(challenge)
    if challenge
      winners = challenge.guesses.where(:status => STATUS_RIGHT) 
    else
      winners = nil
    end
  end


  def email_content(complete_challenge, new_challenge)
    email_string = "Dear Sparks,\n\n"

    if complete_challenge
      email_string += "Here are the results of the current \"Geek of the Week\" competition:\n\n"

      email_string += "Challenge: " + complete_challenge.question + "\n"
      if !new_challenge.hint.blank?
        email_string += "Hint: " + complete_challenge.hint + "\n"
      end
      email_string += "Answer: " + complete_challenge.answer + "\n"
      email_string += "Setter: " + complete_challenge.user.first_name + " " + complete_challenge.user.last_name + "\n"

      if challenge_winners(complete_challenge).count > 0
        email_string += "Winning " + "Geek".pluralize(challenge_winners(complete_challenge).count) + ": "
        email_string += challenge_winners(complete_challenge).map {|guess| guess.user.first_name + " " + guess.user.last_name}.join(", ") + "\n\n"
      else
        email_string += "There were no Geek of the Weeks this week!\n\n"
      end
    end
    email_string += "Here is the new \"Geek of the Week\" challenge:\n"
    email_string += "Challenge: " + new_challenge.question + "\n"
    if !new_challenge.hint.blank?
      email_string += "Hint: " + new_challenge.hint + "\n" 
    end
    
    email_string += "\nYou can enter the latest challenge by visiting http://" + request.host + url_for(geek_of_the_week_path) + " - good luck!\n\n"

    email_string += new_challenge.user.first_name

    return email_string

  end
  def generate_mail
    return mail_to "test@test.com", "Company email", subject: "Geek of the Week - "+Date.today.to_formatted_s(:rfc822), body: email_content(Challenge.last.previous,Challenge.last), id: "autoEmail"
  end



end
