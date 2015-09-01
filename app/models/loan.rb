class Loan < ActiveRecord::Base

  Pending = 'Pendiente'
  Approved = 'Aprobado'
  Declined = 'Declinado'
  Paid = 'Pagado'
  
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

  def amortization_calculation current_date: Date.today, current_payment_amount: 0
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
    total_extra_capital = 0

    payment_counter = 1

    loop do
      payments_on_delay = 0
      payment_day = self.emission_date + payment_counter.month
      Rails.logger.info "payment_day: #{payment_day}"
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
      if payment_counter == 1
        payments_in_this_month = Payment.where {
            (payment_date.lt my{payment_day + 1.month}) &
            (payment_date.lteq my{current_date}) &
            (loan_id.eq my{self.id}) &
            (capital_payment.eq 0)
          }
      else
        payments_in_this_month = Payment.where {
            (payment_date.gteq my{payment_day}) &
            (payment_date.lt my{payment_day + 1.month}) &
            (payment_date.lteq my{current_date}) &
            (loan_id.eq my{self.id}) &
            (capital_payment.eq 0)
          }
      end

      Rails.logger.info "Payments in this month = #{payments_in_this_month.inspect}"
      actual_payment_date = payments_in_this_month.map(&:payment_date).min

      # group payments by before & after late fee date
      payments_by_fee = payments_in_this_month.group_by do |p|
        p.payment_date <= payment_day + late_fee_days ? :without_fee : :with_fee
      end

      Rails.logger.info "payments_without_fee: #{payments_by_fee[:without_fee].inspect}"
      Rails.logger.info "payments_with_fee: #{payments_by_fee[:with_fee].inspect}"
      payments_on_delay += payments_by_fee[:with_fee].try(:count) || 0

      amount_without_fee = (payments_by_fee[:without_fee] || []).inject(0){ |sum, x| sum + (x.amount || 0) }
      amount_with_fee = (payments_by_fee[:with_fee] || []).sum(&:amount)
      if current_payment_amount.to_f > 0 && (current_date >= payment_day) && (current_date < payment_day + 1.month)
        if current_date <= payment_day + late_fee_days
          amount_without_fee += current_payment_amount.to_f
        else
          amount_with_fee += current_payment_amount.to_f
        end
      end


      amount_without_fee = monthly_payment if is_future_period
      Rails.logger.info "amount_without_fee = #{amount_without_fee}"

      paid_in_fact = amount_without_fee + amount_with_fee + total_extra_capital

      Rails.logger.info "unpaid balance = #{unpaid_balance}"
      Rails.logger.info "[monthly_payment - amount_without_fee, 0].max = #{[BigDecimal.new(monthly_payment) - BigDecimal.new(amount_without_fee), BigDecimal.new(0)].max}"

      late_sub = [monthly_payment - amount_without_fee, 0].max + unpaid_balance
      if late_sub > 0
        difference = late_sub - total_extra_capital
        total_extra_capital = [-difference, 0].max
        late_sub = [difference, 0].max
      end
      late_fee = late_sub * late_fee_rate
      to_pay = unpaid_balance + monthly_payment + late_fee
      unpaid_balance = [to_pay - paid_in_fact, 0].max

      late_fee = 0 if is_future_period

      extra_capital_payment = [ paid_in_fact - to_pay, 0 ].max
      total_extra_capital = extra_capital_payment

      # Remaining debt after payment
      balance = balance * (1 + monthly_rate) - paid_in_fact
      capital_payments = Payment.where {
            (payment_date.lt my{payment_day + 1.month}) &
            (payment_date.gteq my{payment_day}) &
            (payment_date.lt my{payment_day + 1.month}) &
            (loan_id.eq my{self.id}) &
            (capital_payment.not_eq 0)
      }
      balance -= capital_payments.sum(:capital_payment)

      # total_late_debt = 0

      balance = balance <= 0 ? 0.0 : balance

# binding.pry if payment_counter == 11

      period_values[:periods][payment_day] = {
        monthly_payment: monthly_payment,
        capital: capital < 0 ? 0 : capital,
        interest: interest,
        balance: balance_start_of_month,
        total_interest: total_interest,
        paid_in_fact: is_future_period ? 0 : paid_in_fact,
        late_fee: late_fee,
        extra_capital: 0,
        net_balance: is_future_period ? 0 : unpaid_balance,
        payments_on_delay: payments_on_delay,
        actual_payment_date: actual_payment_date,
        fresh_balance: balance
      }

      payment_counter += 1
      break if balance == 0 || (monthly_payment < interest && (payment_day + 1.month) > current_date)
      # break if (payment_day + 1.month) > current_date
    end

    period_values
  end

  def values_for_now
    payment_date = Date.today
    daily_rate = self.financing_rate / 36000
    amortization = amortization_calculation[:periods].select {|period, values| (period ... period + 1.month) === payment_date }
    if amortization.present?
      last_period = amortization.keys.first
      values = amortization.values.first
      remain_days = (payment_date - last_period).to_i
      values[:fresh_balance]+ values[:late_fee] + self.amount * daily_rate * remain_days
    else
      0
    end
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