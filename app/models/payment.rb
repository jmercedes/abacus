class Payment < ActiveRecord::Base
  belongs_to :loan
  
  after_create :update_loan_balance
  
  def update_loan_balance
    with_lock do
      payment = self.loan.amount - self.amount
      loan.update(amount: payment)
      loan.save
    end
  end
  
  def self.calculate_late_fee
      loan = Loan.last
      late_fee_rate = 0.05
      payment_day = loan.emision_date.strftime("%d")
      puts payment_day 
  end
  
  
end