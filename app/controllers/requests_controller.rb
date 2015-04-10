class RequestsController < ApplicationController
  before_action :set_user
  before_action :set_request, only: [:show]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requests }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.user = @user

    respond_to do |format|
      if @request.save
        format.html { redirect_to [@user, @request], notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_request
      @request = @user.requests.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def request_params
      params.require(:request).permit(:amount, :financing_time)
    end
end
