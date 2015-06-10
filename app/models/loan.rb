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
  
  #validates :funds_availability

  scope :approved_loans, lambda { where(status: Loan::Approved) }

  Statuses.each do |status|
    define_method "#{status}?" do 
      self.status == status
    end
  end

  def amortization_calculation
    monthly_rate = self.financing_rate / 1200
    total_interest = 0
    payment_day = self.emision_date

    # Monthly payment amount - the same for each month
    payment_amount = self.amount * ( (monthly_rate * ( 1 + monthly_rate)**self.financing_time) / ( ( 1 + monthly_rate )**self.financing_time - 1) ) 
    debt = self.amount

    period_values = []

    self.financing_time.times do |payment_counter|
      # Interest
      interest = debt * monthly_rate

      # Remaining debt after payment
      debt = debt * (1 + monthly_rate) - payment_amount

      # Principal / Capital
      capital = payment_amount - interest
       
      #Total interest
      total_interest += interest

      payment_day += 1.month

      period_values << [ payment_counter + 1, payment_day, payment_amount.to_f, capital, interest, debt, total_interest ]
    end

    period_values
  end

  private 

  def set_default_financing_rate
    self.financing_rate = DefaultFinancingRate
  end

  def update_account_balance
    with_lock do
      loan_amount = self.account.amount - self.loan.amount
    end
  end
  
  #Validate if there are funds available before granting the loan.
  #def self.funds_availability
    #self.loan.amount > Account.sum(:amount)
  #end
end