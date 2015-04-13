class Admin::RequestsController <  Admin::BaseController
  before_action :set_admin_request, only: [:show, :edit, :update, :destroy]

  # GET /admin/requests
  # GET /admin/requests.json
  def index
    @requests = ::Request.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requests }
    end
  end

  # GET /admin/requests/1
  # GET /admin/requests/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  # GET /admin/requests/new
  def new
    @request = ::Request.new
  end

  # GET /admin/requests/1/edit
  def edit
  end

  # POST /admin/requests
  # POST /admin/requests.json
  def create
    @request = ::Request.new(admin_request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to [:admin, @request], notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/requests/1
  # PATCH/PUT /admin/requests/1.json
  def update
    respond_to do |format|
      if @request.update(admin_request_params)
        format.html { redirect_to [:admin, @request], notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/requests/1
  # DELETE /admin/requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to admin_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_request
      @request = ::Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_request_params
      params.require(:request).permit(:user_id, :amount, :financing_time, :financing_rate, :status)
    end
end
