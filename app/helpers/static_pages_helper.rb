module StaticPagesHelper

  def list_of_geeks
    if @correct_guesses
      sorted_guesses = @correct_guesses.order("user_id desc")
      geeks = []
      last_geek_id = sorted_guesses.first[:user_id]
      last_geek_count = 0
      sorted_guesses.each do |guess|
        if guess[:user_id] == last_geek_id || guess == sorted_guesses.first
          last_geek_count += 1
        else
          geeks << {geek_id: last_geek_id, geek_count: last_geek_count}
          last_geek_id = guess[:user_id]
          last_geek_count = 1
        end
      end
      geeks << {geek_id: last_geek_id, geek_count: last_geek_count}
      return geeks
    else
      return nil
    end
  end

  def sorted_list_of_geeks
    if list_of_geeks
      return list_of_geeks.sort_by {|geek| geek[:geek_count]}.reverse #Needs to be descending so reverse!
    else
      return nil
    end
  end

end
