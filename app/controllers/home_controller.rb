class HomeController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json
    
  def index
    
    #@user_loan = current_user.requests
    
    if current_user.loan.nil?
      
       @borrowed_amount = 0
       @monthly_payment = 0
    else
       amortization = current_user.loan.amortization_calculation
       @remaining_balance = amortization[:periods].find do |payment_day, period|
         (payment_day ... payment_day + 1.month) === amortization[:current_date]
       end.last[:balance]
       
       @monthly_payment = amortization[:periods].values[0][:monthly_payment]
       
       @monthly_payments_amount_made = current_user.loan.payments.map(&:amount).sum
       
       
       @monthly_payments_quantity_delayed = amortization[:periods].select do |payment_day, period|
         period[:paid_in_fact] == 0 &&
         payment_day <= amortization[:current_date] &&
         period[:late_fee] != 0
       end.size
       
       
       @borrowed_amount = current_user.loan.amount   
       @loan_emission_date = current_user.loan.emission_date
       @loan_financing_time = current_user.loan.financing_time
       
       @all_payments = current_user.loan.payments.all
       @amortization = current_user.loan.amortization_calculation
       
       @remaining_payments = current_user.loan.financing_time - current_user.loan.payments.count
       
       @payments_count = current_user.loan.payments.count
       
       # Monthly payments quantity delayed
       @delayed_payments_quantity = amortization[:periods].select do |payment_day, period|
         period[:paid_in_fact] == 0 &&
         payment_day <= amortization[:current_date] &&
         period[:late_fee] != 0
       end.size
       
       #delayed monthly balance amount
       
         
        @loan_track = []
        amortization[:periods].each do |payment_day, period|
         @loan_track << period[:balance] # getting balance
         @loan_track << period[:payment_day]
       end
       
       
       @amortization = amortization
       
       @morris_chart = @amortization[:periods].inject([]) do |json_data, (key,value)|
         json_data << { payment_date: key, balance: value[:balance].round(2), payment: value[:paid_in_fact] }
         json_data
       end.to_json
       
       
       @all_payments = current_user.loan.payments.all || []
       
    end   
    
    #@loan_amount = current_user.loan.nil? ? 0 : current_user.loan.amount
    
    #@total_payments_amount = current_user.loan.nil?
    
    #@payment_quantity = current_user.loan.financing_time.nil? ? 0 : current_user.loan.financing_time  
    
  end
end
