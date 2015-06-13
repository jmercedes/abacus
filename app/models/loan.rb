class Loan < ActiveRecord::Base

  Pending = 'Pendiente'
  Approved = 'Aprobado'
  Declined = 'Declinado'

  DefaultFinancingRate = 7

  Statuses = [Pending, Approved, Declined]

  before_validation :set_default_financing_rate, if: Proc.new { self.financing_rate.blank? }

  has_many :payments, dependent: :destroy
  belongs_to :user

  validates :user_id, :emission_date, presence: true
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
    late_fee_days = 5.days
    late_fee_rate = 0.05

    monthly_rate = self.financing_rate / 1200
    total_interest = 0

    # Monthly payment amount - the same for each month
    monthly_payment = self.amount * ( (monthly_rate * ( 1 + monthly_rate)**self.financing_time) /
                    ( ( 1 + monthly_rate )**self.financing_time - 1) )

    balance = self.amount
    period_values = []

    self.payment_days.each_with_index do |payment_day, payment_counter|
      monthly_debt = 0
      extra_capital_payment = 0

      # Interest
      interest = balance * monthly_rate

      #Total interest
      total_interest += interest

      # Principal / Capital
      capital = monthly_payment - interest

      # get all payments in this month
      payments_in_this_month = Payment.where {
          (payment_date.gteq my{payment_day}) &
          (payment_date.lt my{payment_day + 1.month}) &
          (loan_id.eq my{self.id})
        }

      # group payments by before & after late fee date
      payments_by_fee = payments_in_this_month.group_by do |p|
        p.payment_date <= payment_day + late_fee_days ? :without_fee : :with_fee
      end

      amount_without_fee = (payments_by_fee[:without_fee] || []).sum(&:amount)
      amount_with_fee = (payments_by_fee[:with_fee] || []).sum(&:amount)
      paid_in_fact = amount_without_fee + amount_with_fee

      monthly_debt = monthly_payment - amount_without_fee

      # calculate late fee if a client has any monthly debt
      # if monthly debt is equal 0, then we'll not have any fee
      late_fee = monthly_debt * late_fee_rate

      monthly_debt -= amount_with_fee - late_fee

      if monthly_debt <= 0
        extra_capital_payment = monthly_debt.abs
        balance -= capital + extra_capital_payment
      else # monthly_debt > 0
        balance += monthly_debt - capital
      end

      # Remaining debt after payment
      # balance = balance * (1 + monthly_rate) - paid_in_fact + late_fee
      # balance = balance * (1 + monthly_rate) - monthly_payment

      period_values << {
        payment_counter: payment_counter + 1,
        payment_day: payment_day,
        monthly_payment: monthly_payment,
        capital: capital,
        interest: interest,
        balance: balance,
        total_interest: total_interest,
        paid_in_fact: amount_without_fee + amount_with_fee,
        late_fee: late_fee,
        extra_capital: extra_capital_payment
      }
    end

    period_values
  end

  def payment_days
    (1..self.financing_time).map do |month_counter|
      self.emission_date + month_counter.month
    end
  end

  private 

  def set_default_financing_rate
    self.financing_rate = DefaultFinancingRate
  end
  
  #Validate if there are funds available before granting the loan.
  #def self.funds_availability
    #self.loan.amount > Account.sum(:amount)
  #end
end