class GuessesController < ApplicationController
  before_action :set_guess, only: [:show, :edit, :update, :destroy]

  # GET /guesses
  # GET /guesses.json
  def index
    @guesses = Guess.all
  end

  # GET /guesses/1
  # GET /guesses/1.json
  def show
  end

  # GET /guesses/new
  def new
    @guess = Guess.new

  end

  # GET /guesses/1/edit
  def edit
  end

  # POST /guesses
  # POST /guesses.json
  def create
    @guess = Guess.new(guess_params)

    #set the current time
    current_time = DateTime.now
    last_challenge = Challenge.where(created_at: current_time-(7.day)..current_time).first
    @guess.challenge = last_challenge

    #find user by first and last name
    # @guess.user = User.find_by(first_name: :user_first_name.capitalize, last_name: :user_last_name.capitalize)
    @guess.user = User.find(1)

    #set initial status to be wrong
    @guess.status = STATUS_WRONG


    respond_to do |format|
      if @guess.save
        format.html { redirect_to @guess, notice: 'Guess was successfully created.' }
        format.json { render :show, status: :created, location: @guess }
      else
        format.html { render :new }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guesses/1
  # PATCH/PUT /guesses/1.json
  def update
    respond_to do |format|
      if @guess.update(guess_params)
        format.html { redirect_to @guess, notice: 'Guess was successfully updated.' }
        format.json { render :show, status: :ok, location: @guess }
      else
        format.html { render :edit }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guesses/1
  # DELETE /guesses/1.json
  def destroy
    @guess.destroy
    respond_to do |format|
      format.html { redirect_to guesses_url, notice: 'Guess was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guess
      @guess = Guess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guess_params
      params.require(:guess).permit(:answer, :status)
    end
end
