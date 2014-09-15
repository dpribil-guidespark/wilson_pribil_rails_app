class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_context

  def find_user_by_name(first, last)
    #find user by first and last name
    user_params = {first_name: first, last_name: last}
    user = User.find_by(user_params)
    user || User.create(user_params)
  end

  private
    def set_context
      @context = request.original_url.include?('geek_of_the_week') ? CONTEXT_GEEK_OF_THE_WEEK : CONTEXT_REQ_OF_THE_WEEK;
    end

end
