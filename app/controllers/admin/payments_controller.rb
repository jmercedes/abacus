class Admin::PaymentsController < Admin::BaseController
  before_action :set_admin_payment, only: [:show, :edit, :update, :destroy]
  
  def index
    @payments = ::Payment.all
  end
  
  def new
    @payment = ::Payment.new
  end
  
  def edit
  end

  def create
    @payment = ::Payment.new(admin_payment_params)

    respond_to do |format|
      if @payment.save
         loan = Loan.find(@payment.loan_id)
         @user = User.find(loan.user_id)
         Notification.payment_notification(@user).deliver
        format.html { redirect_to [:admin, :payments], notice: 'Payment was successfully created.' }
        format.json { render json: @payment, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  def update
    respond_to do |format|
      if @payment.update(admin_payment_params)
        format.html { redirect_to [:admin, @payment], notice: 'Loan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to admin_payments_url }
      format.json { head :no_content }
    end
  end

  def calculate_late_fee
    loan = Loan.find(params[:loan_id])
    payment_date = Date.parse(params[:payment_date])

    late_fee = 0

    # loan_payment_date = loan.payment_days.find{|loan_payment| loan_payment > (payment_date - 1.month) }

    # # there would be a penalty if a payment date is made after a 5 days of loan payment date
    # days_diff = (payment_date - loan_payment_date).to_i

    # # late_fee = all previous debt * 5%
    # late_fee = if days_diff > 5
      
    # else
    #   0
    # end

    # payment = Payment.where {
    #     (payment_date.lteq my{loan_payment_date}) &
    #     (payment_date.gteq my{payment_date + 1.month}) &
    #     (loan_id.eq my{loan.id})
    #   }

    render text: late_fee
  end

  private

  def set_admin_payment
    @payment = ::Payment.find(params[:id])
  end

  def admin_payment_params
    params.require(:payment).permit(:amount, :payment_date, :loan_id, :late_fee)
  end
end