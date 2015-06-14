class ChangeLoansAndPayments < ActiveRecord::Migration
  def up
    change_column :loans, :financing_rate, :decimal, precision: 8, scale: 2
    change_column :payments, :amount, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :loans, :financing_rate, :decimal
    change_column :payments, :amount, :decimal
  end
end
