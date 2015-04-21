class Deposit < ActiveRecord::Base
  belongs_to :account
  
  validates :account_id, :amount, presence: true
  validates :amount, numericality: true
  
  after_create :update_account_amount
  
  def update_account_amount
    with_lock do
      total_amount =  self.account.amount + self.amount
      account.update(amount: total_amount)
      account.save
    end
  end 
  
end
