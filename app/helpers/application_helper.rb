module ApplicationHelper

  def get_about_path
    if @context == CONTEXT_UNDEFINED
      about_path
    elsif @context == CONTEXT_GEEK_OF_THE_WEEK
      geek_of_the_week_about_path
    elsif @context == CONTEXT_REQ_OF_THE_WEEK
      req_of_the_week_about_path
    end
  end

  def get_home_path
    if @context == CONTEXT_UNDEFINED
      root_path
    elsif @context == CONTEXT_GEEK_OF_THE_WEEK
      geek_of_the_week_home_path
    elsif @context == CONTEXT_REQ_OF_THE_WEEK
      req_of_the_week_home_path
    end
  end

end
