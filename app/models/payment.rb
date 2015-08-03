class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
