class Request < ActiveRecord::Base

  Pending = 'pending'
  Approved = 'approved'
  Declined = 'declined'

  DefaultFinancingRate = 7

  Statuses = [Pending, Approved, Declined]

  belongs_to :user

  before_validation :set_default_financing_rate

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :financing_time, presence: true, numericality: {greater_than: 0}
  validates :financing_rate, presence: true, numericality: {greater_than: 0}
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

end
