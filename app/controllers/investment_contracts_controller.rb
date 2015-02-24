class InvestmentContractsController < ApplicationController

def index
  @investment_contacts = InvestmentContract.all
end  

def show
end

def new
  @investment_contract = InvestmentContract.new
end

def edit
end  

def update
end

def destroy
end

private

  def set_investment_contract
  end
  
  def set_params
    
  end


end