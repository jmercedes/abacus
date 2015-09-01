class Admin::PaymentsController < Admin::BaseController
  before_action :set_admin_payment, only: [:show, :edit, :update, :destroy]

  def index
    @payments = ::Payment.all
    @loans = ::Loan.all
  end

  def new

    @loan = ::Loan.find(params[:loan_id])
    @payment = @loan::payments.build
    @operation = params[:operation]
    @balance = @loan.try(:values_for_now).try(:round, 2)

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

    period = loan.amortization_calculation(current_date: payment_date, current_payment_amount: params[:amount])[:periods].select do |payment_day, period|
      (payment_day ... payment_day + 1.month) === payment_date
    end.values.first

    late_fee = period.try(:[], :late_fee).try(:round, 2) || 0

    render text: late_fee
  end

  def loans
    @operation = params[:operation]
    @loans = Loan.approved_loans.select{ |loan| loan.values_for_now != (nil || 0) }
  end

  def closure_loan
    @payment = ::Payment.new(admin_payment_params)
    @payment.for_close(true)
    respond_to do |format|
      if @payment.save
        loan = Loan.find(@payment.loan_id)
        loan.update_attribute(:status, Loan::Paid)
        @user = User.find(loan.user_id)
        format.html { redirect_to loans_admin_payments_path, notice: 'Payment was successfully created. Loan was paid' }
        format.json { render json: @payment, status: :created }
      else
        format.html { redirect_to new_admin_payment_path(loan_id: params[:payment][:loan_id], operation: "closure"), flash: {error: @payment.errors.full_messages} }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end

  end

  def capital_payment
    @payment = ::Payment.new(admin_payment_params)
    @payment.for_capital
    respond_to do |format|
      if @payment.save
        loan = Loan.find(@payment.loan_id)
        @user = User.find(loan.user_id)
        format.html { redirect_to loans_admin_payments_path, notice: 'Capital payment was successfully created. Balance of loan was changed' }
        format.json { render json: @payment, status: :created }
      else
        format.html { redirect_to new_admin_payment_path(loan_id: params[:payment][:loan_id], operation: "capital"), flash: {error: @payment.errors.full_messages} }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

  def set_admin_payment
    @payment = ::Payment.find(params[:id])
  end

  def admin_payment_params
    params.require(:payment).permit(:amount, :payment_date, :loan_id, :late_fee)
  end
end