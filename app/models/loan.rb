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
      with_lock do
        loan_amount = self.account.amount - self.loan.amount
      end
    end
    
    #Validate if there are funds available before granting the loan.
    #def self.funds_availability
      #self.loan.amount > Account.sum(:amount)
    #end
    
    def self.amortization_calculation
      loan_amount = 250000
      rate = 0.42 / 12
      periods = 60
      payment_counter = 0
      total_interest = 0
      payment_day = Date.today 

      #Monthly payment amount
      payment_amount = loan_amount * ( (rate * ( 1 + rate)**periods)  / ( ( 1 + rate )**periods - 1) ) 

      amortization_table = []
      period_values = []

      periods.times do |period|
          
          payment_counter += 1
          
          #Monthly payment
          payment = payment_amount

          #Remaining debt after payment
          loan_amount = loan_amount * (1 + rate) - payment_amount

          #Interest
          interest = loan_amount * rate

          #Principal
          capital = payment - interest
           
          #Total interest
          total_interest = total_interest + interest
          
          payment_day += 1.month

          period_values << [payment_counter, payment_day, payment, capital, interest, loan_amount, total_interest ]

          #amortization_table << period_values
      end
          period_values
          #amortization_table
      
    end
    
end
