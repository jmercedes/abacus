class Admin::PaymentsController < Admin::BaseController
  before_action :set_admin_payment, only: [:show, :edit, :update, :destroy]
  
  def index
    @payments = ::Payment.all
    @loans = ::Loan.all
  end
  
  def new
    
    @loan = ::Loan.find(params[:loan_id])
    @payment = @loan::payments.build
    
    #@payment = ::Payment.new
    #@prescription = @patient.prescriptions.build #Prescription.new
    
    
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

    period = loan.amortization_calculation(current_date: payment_date)[:periods].select do |payment_day, period|
      (payment_day ... payment_day + 1.month) === payment_date
    end.values.first

    late_fee = period.try(:[], :late_fee).try(:round, 2) || 0

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