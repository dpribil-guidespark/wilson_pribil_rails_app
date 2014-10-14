class ChallengesController < ApplicationController
  http_basic_authenticate_with name: GOTW_USERNAME, password: GOTW_PASSWORD, only: [:new, :create]
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :latest_challenge]
  before_action :set_user, only: [:edit, :update, :show, :latest_challenge]

  # GET /challenges
  # GET /challenges.json
  def index
    @challenges = Challenge.all
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
  end

  # GET /challenges/new
  def new
  end

  # GET /challenges/1/edit
  def edit
  end

  def latest_challenge
    flash[:tab] = 'leaderboard_tab' if params[:historic_challenge]
    render 'show'
  end

  # POST /challenges
  # POST /challenges.json
  def create
    # set user from username
    @user = find_user_by_name params[:challenge][:first_name].capitalize, params[:challenge][:last_name].capitalize

    cookies.permanent[:guess_game_first_name] = @user.first_name
    cookies.permanent[:guess_game_last_name] = @user.last_name

    @challenge = @user.challenges.new(challenge_params)

    #find user by first and last name
    #@challenge.user = User.find_by(first_name: :user_first_name.capitalize, last_name: :user_last_name.capitalize)
    if Challenge.all.count>1
      @previous_challenge=Challenge.all[-2]   
    else
      @previous_challenge = nil
    end


    respond_to do |format|
      if @challenge.save
        flash[:notice] = 'Challenge was successfully created.'
        flash[:send_notification_email] = params[:challenge][:send_notification_email] == "true"
        format.html { redirect_to geek_of_the_week_path}
      else
        flash[:alert] = 'The question with the same answer was asked before!'
        format.html { redirect_to new_geek_of_the_week_path }
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        flash[:notice] = 'Challenge was successfully updated.'
        format.html { redirect_to geek_of_the_week_path}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      flash[:notice] = 'Challenge was successfully destroyed.'
      format.html { redirect_to geek_of_the_week_path}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = get_latest_challenge
      if Challenge.all.count>1
        @guesses=Guess.all
        @correct_guesses = !@guesses.empty? ? @guesses.where(:status => STATUS_RIGHT) : nil
      end
    end

    def set_user
      @user = @challenge.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit(:question, :hint, :answer)
    end

    def get_latest_challenge
      @challenge = Challenge.last
    end

end
