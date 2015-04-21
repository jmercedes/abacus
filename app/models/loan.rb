class Loan < ActiveRecord::Base

  Pending = 'Pendiente'
  Approved = 'Aprobado'
  Declined = 'Declinado'

  DefaultFinancingRate = 7

  Statuses = [Pending, Approved, Declined]

  before_validation :set_default_financing_rate, if: Proc.new { self.financing_rate.blank? }

  has_many :payments
  belongs_to :user

  validates :user_id, :emision_date, presence: true
  validates :amount, presence: true
  validates :financing_time, presence: true, numericality: {greater_than: 0}
  validates :financing_rate, presence: true, inclusion: { in: 1..100 }
  validates :status, presence: true, inclusion: {in: Statuses }

  Statuses.each do |status|
    define_method "#{status}?" do 
      self.status == status
    end
  end

  private 

    def set_default_financing_rate
      self.financing_rate = DefaultFinancingRate
    end

    scope :approved_loans, lambda { where(status: Loan::Approved) }
    
    def update_account_balance
      #with_lock do
      #  loan_amount = self.account.amount - self.loan.amount
      #end
    end
    
    
end
