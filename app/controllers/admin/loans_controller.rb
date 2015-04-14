class Admin::LoansController < ApplicationController
  before_action :set_admin_loans, only: [:show, :edit, :update, :destroy]
  
  def index
    @loans = ::Loan.all
  end
  
  def new
    @loan = ::Loan.new
  end
end
