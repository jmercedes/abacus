class Reference < ActiveRecord::Base
  belongs_to :profile

  validates :name, presence: true
  
  
end