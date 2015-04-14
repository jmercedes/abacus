class Admin::Dashboard < ActiveRecord::Base
  

  def active_loans_count
      #active = Loan.select { |l| l.status == 'Activo' } 
  end

  #Resumen de capital en prestamos
  def loan_capital_amount
      #Take all the loans and substract all that have been paid
  end

  def available_for_loans
      #Account.sum(:amount)
  end
  
  def total_loans_amount_emited
      #Loan.sum(:amount)
  end

  def approved_loans_count
      #Request.count
  end

  def loans_on_delay
      # delayed = Loan.select { |l| l.status == 'Atraso' }
      # delayed.count 
  end  
  
  def expected_monthly_income
      # assing to a variable all the payments according to the current month
      # sum all the values of the array
  end
end
