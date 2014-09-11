module StaticPagesHelper

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
      return list.sort_by {|item| item[:count]}.reverse #Needs to be descending so reverse!
    else
      return nil
    end
  end

  def list_of_geeks
    list_of_creator(:user_id,"user_id")
  end

  def sorted_list_of_geeks
    return sorted_list_of_creator(list_of_geeks)
  end


  def list_of_depts
    list_of_creator(:department,"department")
  end  

  def sorted_list_of_depts
    return sorted_list_of_creator(list_of_depts)
  end


end
