class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :enough_amount

  def for_close(value)
    @for_close = value
  end

  private

  def enough_amount
    if @for_close
      values = self.loan.values_for_now
      balance = (values.try(:[], :balance) + values.try(:[], :late_fee)).try(:round, 2) if values
      if self.amount != balance
        errors.add(:amount, "El balance debe ser igual al monto de cierre")
      end
    end
  end
end
