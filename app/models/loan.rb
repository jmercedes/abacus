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

  def amortization_calculation current_date: Date.today
    late_fee_days = 5.days
    late_fee_rate = 0.05

    monthly_rate = self.financing_rate / 1200
    total_interest = 0

    # Monthly payment amount - the same for each month
    monthly_payment = self.amount * ( (monthly_rate * ( 1 + monthly_rate)**self.financing_time) /
                    ( ( 1 + monthly_rate )**self.financing_time - 1) )

    balance = self.amount
    period_values = { current_date: current_date, periods: {} }
    is_current_month = false

    payment_counter = 1

    loop do
      payment_day = self.emission_date + payment_counter.month

      is_future_period = payment_day > current_date

      monthly_debt = 0
      extra_capital_payment = 0

      # Interest
      interest = balance * monthly_rate

      #Total interest
      total_interest += interest

      # Principal / Capital
      capital = monthly_payment - interest

      # if the last payment, then monthly payment is smaller
      if capital > balance
        monthly_payment = balance + interest
        capital = balance
      end

      # get all payments in this month
      payments_in_this_month = Payment.where {
          (payment_date.gteq my{payment_day}) &
          (payment_date.lt my{payment_day + 1.month}) &
          (payment_date.lteq my{current_date}) &
          (loan_id.eq my{self.id})
        }

      # group payments by before & after late fee date
      payments_by_fee = payments_in_this_month.group_by do |p|
        p.payment_date <= payment_day + late_fee_days ? :without_fee : :with_fee
      end

      amount_without_fee = (payments_by_fee[:without_fee] || []).sum(&:amount)
      amount_with_fee = (payments_by_fee[:with_fee] || []).sum(&:amount)

      amount_without_fee = monthly_payment if is_future_period

      paid_in_fact = amount_without_fee + amount_with_fee

      monthly_debt = monthly_payment - amount_without_fee

      # calculate late fee if a client has any monthly debt
      late_fee = monthly_debt > 0 && current_date >= (payment_day + 5.days) ? monthly_debt * late_fee_rate : 0

      monthly_debt -= amount_with_fee - late_fee

      if monthly_debt <= 0
        extra_capital_payment = monthly_debt.abs
      # TODO: alternative code for balance calculation
      #   balance -= capital + extra_capital_payment
      # else # monthly_debt > 0
      #   balance += monthly_debt - capital
      end

      # Remaining debt after payment
      balance = balance * (1 + monthly_rate) - paid_in_fact + late_fee

      balance = balance <= 0 ? 0.0 : balance

      period_values[:periods][payment_day] = {
        monthly_payment: monthly_payment,
        capital: capital,
        interest: interest,
        balance: balance,
        total_interest: total_interest,
        paid_in_fact: is_future_period ? 0 : amount_without_fee + amount_with_fee,
        late_fee: late_fee,
        extra_capital: extra_capital_payment
      }

      payment_counter += 1
      break if balance == 0
    end

    period_values
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