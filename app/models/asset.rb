class Asset < ActiveRecord::Base
  belongs_to :profile

  validates :name, presence: true

end