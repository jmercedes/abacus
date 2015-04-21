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
  
  
end