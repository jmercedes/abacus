class InvestmentContract < ActiveRecord::Base
  
  has_one :contract_template
  
end