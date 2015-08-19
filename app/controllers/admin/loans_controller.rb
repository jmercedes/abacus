class Admin::LoansController <  Admin::BaseController
  before_action :set_admin_loan, only: [:show, :edit, :update, :destroy, :amortization]

  def index
    @loans = ::Loan.all
    @loans_count = @loans.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loans }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @loan }
    end
  end

  def new
    @loan = ::Loan.new
  end

  def edit
  end

  def create
    @loan = ::Loan.new(admin_loan_params)

    respond_to do |format|
      if @loan.save
        format.html { redirect_to [:admin, @loan], notice: 'Loan was successfully created.' }
        format.json { render json: @loan, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @loan.update(admin_loan_params)
        format.html { redirect_to [:admin, @loan], notice: 'Loan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to admin_loans_url }
      format.json { head :no_content }
    end
  end

  def amortization
    @client = "#{@loan.user.try(:profile).names} #{@loan.user.try(:profile).lastnames}"
    @payments = @loan.payments
    @amortization = @loan.amortization_calculation

    @morris_chart = @amortization[:periods].inject([]) do |json_data, (key,value)|
      json_data << { payment_date: key, balance: value[:balance].round(2), payment: value[:paid_in_fact] }
      json_data
    end.to_json
  end

  private

  def set_admin_loan
    @loan = ::Loan.find(params[:id])
  end

  def admin_loan_params
    params.require(:loan).permit(:amount, :financing_rate, :financing_time, :emission_date, :user_id, :status)
  end

end