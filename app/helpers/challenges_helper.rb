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
        email_string += challenge_winners(complete_challenge).map { |guess| guess.user.first_name + " " + guess.user.last_name }.join(", ") + "\n\n"
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
    return mail_to "test@test.com", "Company email", subject: "Geek of the Week - "+Date.today.to_formatted_s(:rfc822), body: email_content(Challenge.last.previous, Challenge.last), id: "autoEmail"
  end

  def list_of_creator(id_field, id_name)
    if @correct_guesses
      sorted_guesses = @correct_guesses.order("#{id_name} desc")
      outputs = []
      last_id = sorted_guesses.first[id_field]
      last_count = 0
      sorted_guesses.each do |guess|
        if guess[id_field] == last_id || guess == sorted_guesses.first
          last_count += 1
        else
          outputs << {id: last_id, count: last_count}
          last_id = guess[id_field]
          last_count = 1
        end
      end
      outputs << {id: last_id, count: last_count}
      return outputs
    else
      return nil
    end
  end

  def sorted_list_of_creator(list)
    if list
      return list.sort_by { |item| item[:count] }.reverse #Needs to be descending so reverse!
    else
      return nil
    end
  end

  def list_of_geeks
    list_of_creator(:user_id, "user_id")
  end

  def sorted_list_of_geeks
    return sorted_list_of_creator(list_of_geeks)
  end


  def list_of_depts
    list_of_creator(:department, "department")
  end

  def sorted_list_of_depts
    return sorted_list_of_creator(list_of_depts)
  end

  def list_of_geeks_and_depts
    g_d_list = []
    geek_list = self.list_of_geeks

    geek_list.each do |g|
      tmp_hash = {}
      tmp_hash[:id] = g[:id]
      tmp_hash[:dept] = []
      g_d_list << tmp_hash
    end

    correct_g = !Guess.all.empty? ? Guess.all.where(:status => STATUS_RIGHT) : nil

    correct_g.each do |cg|
      tmp_hash = g_d_list.detect { |g| g[:id] == cg[:user_id] }
      dept_name = cg.department
      tmp_hash[:dept].push(dept_name) unless tmp_hash[:dept].include?(dept_name)
    end

    return g_d_list
  end

  def geek_depts(geek)
    if !@geeks_depts_list
      @geek_dept_list = list_of_geeks_and_depts
    end

    tmp_hash = @geek_dept_list.detect { |g| g[:id] == geek[:id] }

    return tmp_hash[:dept].map { |d| Guess.get_department_name(d) }

  end

  def dept_pie_chart
    dept_results = sorted_list_of_depts
    dept_list = []
    dept_results.each do |dept|
      dept_list << [Guess.get_department_name(dept[:id]),dept[:count]]
    end

    pie_chart = Highcharts.new do |chart|
      chart.chart(renderTo: 'piechart', type: 'pie')
      chart.title('Department Leaderboard')
      chart.plotOptions(allowPointSelect: true, cursor: 'pointer')
      chart.series([{type: 'pie', name: 'Geeks', data: dept_list }])
      chart.credits(enabled: false)
    end

    return pie_chart
  end


end
