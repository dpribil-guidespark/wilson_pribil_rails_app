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
      tmp_hash = g_d_list.detect{|g| g[:id] == cg[:user_id]}
      dept_name = cg.department
      tmp_hash[:dept].push(dept_name) unless tmp_hash[:dept].include?(dept_name)
    end

    return g_d_list
  end

  def geek_depts(geek)
    if !@geeks_depts_list
      @geek_dept_list = list_of_geeks_and_depts
    end

    tmp_hash = @geek_dept_list.detect{|g| g[:id] == geek[:id]}

    return tmp_hash[:dept].map{|d| Guess.get_department_name(d) }

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
