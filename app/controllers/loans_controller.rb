class LoansController < ApplicationController
  before_action :set_user
  before_action :set_loan, only: [:show]
  
  def index
    @loan = @user.loan.nil? ? 0 : @user.loan
    @payments = @loan.payments

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
    @loan = Loan.new
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.user = @user

    respond_to do |format|
      if @loan.save
        format.html { redirect_to [@user, @loan], notice: 'Loan was successfully created.' }
        format.json { render json: @loan, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_loan
      @loan = @user.loans.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def loan_params
      params.require(:loan).permit(:amount, :financing_time, :emission_date)
    end
end
