class Account < ActiveRecord::Base
  
  has_many :deposits
  
  def self.for_select
    all.map{|account| [account.name, account.id] }
  end
  
  
end
