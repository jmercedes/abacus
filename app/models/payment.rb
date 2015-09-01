class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :enough_amount
  validate :not_more_amount

  def for_close(value = true)
    @for_close = value
  end

  def for_capital(value = true)
    @for_capital = value
    self.capital_payment = self.amount
  end

  private

  def not_more_amount
    if @for_capital
      balance = self.loan.try(:values_for_now).try(:round, 2)
      if self.amount >= balance
        errors.add(:amount, "Capital payment exceeds the posible amount")
      end
    end
  end

  def enough_amount
    if @for_close
      balance = self.loan.try(:values_for_now).try(:round, 2)
      if self.amount != balance
        errors.add(:amount, "El balance debe ser igual al monto de cierre")
      end
    end
  end
end
