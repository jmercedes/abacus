class AddLateFeeToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :late_fee, :decimal, default: 0
    add_column :loans, :capital_payment, :decimal, default: 0
  end
end
