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
    # if @correct_guesses
    #   sorted_guesses = @correct_guesses.order("user_id desc")
    #   geeks = []
    #   last_geek_id = sorted_guesses.first[:user_id]
    #   last_geek_count = 0
    #   sorted_guesses.each do |guess|
    #     if guess[:user_id] == last_geek_id || guess == sorted_guesses.first
    #       last_geek_count += 1
    #     else
    #       geeks << {geek_id: last_geek_id, geek_count: last_geek_count}
    #       last_geek_id = guess[:user_id]
    #       last_geek_count = 1
    #     end
    #   end
    #   geeks << {geek_id: last_geek_id, geek_count: last_geek_count}
    #   return geeks
    # else
    #   return nil
    # end
    list_of_creator(:user_id,"user_id")
  end

  def sorted_list_of_geeks
    # if list_of_geeks
    #   return list_of_geeks.sort_by {|geek| geek[:count]}.reverse #Needs to be descending so reverse!
    # else
    #   return nil
    # end
    return sorted_list_of_creator(list_of_geeks)
  end


  def list_of_depts
    # if @correct_guesses
    #   sorted_guesses = @correct_guesses.order("department desc")
    #   depts = []
    #   last_dept_id = sorted_guesses.first[:department]
    #   last_dept_count = 0
    #   sorted_guesses.each do |guess|
    #     if guess[:department] == last_dept_id || guess == sorted_guesses.first
    #       last_dept_count += 1
    #     else
    #       depts << {department: last_dept_id, dept_count: last_dept_count}
    #       last_dept_id = guess[:department]
    #       last_dept_count = 1
    #     end
    #   end
    #   depts << {department: last_dept_id, dept_count: last_dept_count}
    #   return depts
    # else
    #   return nil
    # end
    list_of_creator(:department,"department")
  end  

  def sorted_list_of_depts
    # if list_of_depts
    #   return list_of_depts.sort_by {|dept| dept[:dept_count]}.reverse #Needs to be descending so reverse!
    # else
    #   return nil
    # end
    return sorted_list_of_creator(list_of_depts)
  end


end
