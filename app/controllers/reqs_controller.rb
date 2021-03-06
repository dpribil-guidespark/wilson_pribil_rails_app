class ReqsController < ApplicationController
  http_basic_authenticate_with name: ROTW_USERNAME, password: ROTW_PASSWORD, only: [:new, :create]
  before_action :set_req, only: [:show, :edit, :update, :destroy]

  # GET /reqs
  # GET /reqs.json
  def index
    @reqs = Req.all
  end

  # GET /reqs/1
  # GET /reqs/1.json
  def show
  end

  # GET /reqs/new
  def new
    @req = Req.new
  end

  # GET /reqs/1/edit
  def edit
  end

  def latest_req
    get_latest_req
    render 'show'
  end

  # POST /reqs
  # POST /reqs.json
  def create
    @req = Req.new(req_params)

    respond_to do |format|
      if @req.save
        flash[:notice] = 'Req was successfully created.'
        flash[:send_notification_email] = params[:req][:send_notification_email] == "true"
        format.html { redirect_to req_of_the_week_path}
      else
        flash[:alert] = 'There was a problem. Please resubmit the Req of the Week.'
        format.html { redirect_to new_req_of_the_week_path }
      end
    end
  end

  # PATCH/PUT /reqs/1
  # PATCH/PUT /reqs/1.json
  def update
    respond_to do |format|
      if @req.update(req_params)
        format.html { redirect_to @req, notice: 'Req was successfully updated.' }
        format.json { render :show, status: :ok, location: @req }
      else
        format.html { render :edit }
        format.json { render json: @req.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reqs/1
  # DELETE /reqs/1.json
  def destroy
    @req.destroy
    respond_to do |format|
      format.html { redirect_to reqs_url, notice: 'Req was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def req_params
      params.require(:req).permit(:title, :department, :manager, :description)
    end

    def set_req
      @challenge = get_latest_req
    end
    def get_latest_req
      @req = Req.last
    end
end
