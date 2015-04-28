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
    
    def self.amortization_calculation(loan)
         loan_amount = loan.amount
         rate = loan.financing_rate.to_f / 100
         periods = loan.financing_time
         
         payment_amount = loan_amount * ( (rate * ( 1 + rate)**periods)  / ( ( 1 + rate )**periods - 1) )
         #@amortization = Amortization.new(period: periods, amount: loan_amount)
         #amortization = {period: periods, amount: loan_amount, tasa: rate, xxx: payment_amount}
         
         #amortization << payment_amount
         amortization = [payment_amount.to_f, rate, loan_amount, periods]
         #1..loan.financing_time do |i|
           
         #  capital_payment = loan.amount / loan_financing_time
         #  puts "Hello world, this is number #{current_iteration_number}"
         #  #puts "periods #{i}, pago a capital: #{capital_payment}"
         #end
         
         #Amortization.new(loan.amount, loan.financing_rate) 
         #capital = loan.amount
         #rate = loan.financing_rate / 100
         #periods = loan.financing_time
         #time = loan.financing_rate / 12
         #capital * (1 + rate)**time
         
         #loan.financing_time.times do |period|
         #  amortization << period
         #end
    end
    
end
