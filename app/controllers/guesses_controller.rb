class GuessesController < ApplicationController
  before_action :set_guess, only: [:show, :edit, :update, :destroy]
  before_action :set_user_challenge, only: [:index, :create, :destroy]
  http_basic_authenticate_with name: USERNAME, password: PASSWORD, only: [:index, :update_guess_status]

  # GET /guesses
  # GET /guesses.json
  def index
    @guesses = @challenge.guesses
  end

  # POST /guesses
  # POST /guesses.json
  def create
    @guess = @challenge.guesses.new(guess_params)

    #set the current time
    # these are not necessary
    #current_time = DateTime.now
    #last_challenge = Challenge.where(created_at: current_time-(7.day)..current_time).first
    #@guess.challenge = last_challenge

    @guess.user = find_user_by_name params[:guess][:first_name].capitalize, params[:guess][:last_name].capitalize

    # set up the permanent cookie
    cookies.permanent[:guess_game_first_name] = @guess.user.first_name
    cookies.permanent[:guess_game_last_name] = @guess.user.last_name
    cookies.permanent[:guess_game_department] = @guess.department

    #set initial status to be wrong
    @guess.status = STATUS_WRONG


    respond_to do |format|
      if @guess.save
        flash[:notice] = 'Guess was successfully created.'
        flash[:tab] = 'guesses_tab'
        format.html { redirect_to geek_of_the_week_path }
      else
        format.html { redirect_to geek_of_the_week_path }
      end
    end
  end

  def destroy
    @guess.destroy
    respond_to do |format|
      flash[:notice] = 'Guess was successfully destroyed.'
      format.html { redirect_to geek_of_the_week_guesses_path }
    end
  end

  def update_guess_status
    guess = Guess.find(params[:guess_id])
    guess.status = params[:guess_status]
    guess.save
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guess
      @guess = Guess.find(params[:id])
    end

    def set_user_challenge
      @challenge = Challenge.last
      @user = @challenge.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guess_params
      params.require(:guess).permit(:answer, :status, :department)
    end
end
