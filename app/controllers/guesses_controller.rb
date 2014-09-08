class GuessesController < ApplicationController
  before_action :set_guess, only: [:show, :edit, :update, :destroy]
  before_action :set_user_challenge, only: [:index, :create]

  # GET /guesses
  # GET /guesses.json
  def index
    @guesses = Guess.all
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

    #find user by first and last name
    user_params = {first_name: params[:guess][:first_name].capitalize, last_name: params[:guess][:last_name].capitalize}
    user = User.find_by(user_params)
    user ||= User.create(user_params)
    @guess.user = user

    # set up the permanent cookie
    cookies.permanent[:guess_game_first_name] = user.first_name
    cookies.permanent[:guess_game_last_name] = user.last_name


    #set initial status to be wrong
    @guess.status = STATUS_WRONG


    respond_to do |format|
      if @guess.save
        format.html { redirect_to user_challenge_guesses_path(@user, @challenge), notice: 'Guess was successfully created.' }
      else
        format.html { redirect_to user_challenge_path(@user, @challenge) }
      end
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
      @user = User.find(params[:user_id])
      @challenge = Challenge.find(params[:challenge_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guess_params
      params.require(:guess).permit(:answer, :status)
    end
end
