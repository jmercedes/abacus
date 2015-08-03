class Loan < ActiveRecord::Base

  Pending = 'Pendiente'
  Approved = 'Aprobado'
  Declined = 'Declinado'

  DefaultFinancingRate = 42

  Statuses = [Pending, Approved, Declined]

  before_validation :set_default_financing_rate, if: Proc.new { self.financing_rate.blank? }

  has_many :payments, dependent: :destroy
  belongs_to :user

  validates :user_id, :emission_date, presence: true
  validates :amount, presence: true
  validates :financing_time, presence: true, numericality: {greater_than: 0}
  validates :financing_rate, presence: true, inclusion: { in: 0..100 }
  validates :status, presence: true, inclusion: {in: Statuses }
  validate  :not_enough_balance_to_grant_loan

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

    unpaid_balance = 0
    late_fee = 0
    to_pay = 0

    payment_counter = 1

    loop do
      payment_day = self.emission_date + payment_counter.month
      balance_start_of_month = balance
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

      Rails.logger.info "------ paid_in_fact = #{paid_in_fact}"
      late_fee = ([monthly_payment - amount_without_fee, 0].max + unpaid_balance) * late_fee_rate
      Rails.logger.info "------ late_fee = #{late_fee}"
      to_pay = unpaid_balance + monthly_payment + late_fee
      Rails.logger.info "------ to_pay = #{to_pay}"
      unpaid_balance = [to_pay - paid_in_fact, 0].max
      Rails.logger.info "------ unpaid_balance = #{unpaid_balance}"

      late_fee = 0 if is_future_period

      extra_capital_payment = [ paid_in_fact - to_pay, 0 ].max

      # Remaining debt after payment
      balance = balance * (1 + monthly_rate) - paid_in_fact

      # total_late_debt = 0

      balance = balance <= 0 ? 0.0 : balance

# binding.pry if payment_counter == 11

      period_values[:periods][payment_day] = {
        monthly_payment: monthly_payment,
        capital: capital < 0 ? 0 : capital,
        interest: interest,
        balance: balance_start_of_month,
        total_interest: total_interest,
        paid_in_fact: is_future_period ? 0 : amount_without_fee + amount_with_fee,
        late_fee: late_fee,
        extra_capital: extra_capital_payment,
        net_balance: is_future_period ? 0 : unpaid_balance
      }

      payment_counter += 1
      Rails.logger.info "---------------------------------------------------------------------------"
      break if balance == 0 || (monthly_payment < interest && (payment_day + 1.month) > current_date)
      # break if (payment_day + 1.month) > current_date
    end

    period_values
  end


  private

  def set_default_financing_rate
    self.financing_rate = DefaultFinancingRate
  end

  def not_enough_balance_to_grant_loan
    if self.amount > Account.sum(:amount)
      errors.add(:amount, "No hay balance suficiente para otorgar el préstamo")
    end
  end

end