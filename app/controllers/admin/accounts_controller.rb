class Admin::AccountsController <  Admin::BaseController
  before_action :set_admin_account, only: [:show, :edit, :update, :destroy]
  
  def index
    @accounts = ::Account.all
  end
  
  def new
    @account = ::Account.new
  end
  
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end
  
  def create
    @account = ::Account.new(admin_account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to [:admin, @account], notice: 'Request was successfully created.' }
        format.json { render json: @account, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @account.update(admin_account_params)
        format.html { redirect_to [:admin, @account], notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to admin_accounts_url }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_account
    @account = ::Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_account_params
    params.require(:account).permit(:name, :amount, :number, :description, :company_id)
  end
   
end