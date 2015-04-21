class Admin::DepositsController <  Admin::BaseController
  before_action :set_admin_deposit, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @deposits = ::Deposit.all
  end
  
  def new
    @deposit = ::Deposit.new
  end
  
  def edit
  end
  
  def create
    @deposit = ::Deposit.new(admin_deposit_params)

    respond_to do |format|
      if @deposit.save
        format.html { redirect_to [:admin, @deposit], notice: 'Request was successfully created.' }
        format.json { render json: @deposit, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @deposit.update(admin_deposit_params)
        format.html { redirect_to [:admin, @deposit], notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @deposit.destroy
    respond_to do |format|
      format.html { redirect_to admin_deposits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_deposit
      @deposit = ::Deposit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_deposit_params
      params.require(:deposit).permit(:amount, :account_id)
    end    

  
end