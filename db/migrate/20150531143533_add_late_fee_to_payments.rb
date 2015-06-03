class AddLateFeeToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :late_fee, :decimal, default: 0
    add_column :payments, :capital_payment, :decimal, default: 0
  end
end
