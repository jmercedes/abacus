class Admin::PaymentsController < Admin::BaseController
  before_action :set_admin_payment, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @payments = ::Payment.all
    
    @late_fee = Payment.calculate_late_fee
    
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
  end

  def set_admin_payment
    @payment = ::Payment.find(params[:id])
  end

  def admin_payment_params
    params.require(:payment).permit(:amount, :payment_date, :loan_id, :late_fee)
  end
end