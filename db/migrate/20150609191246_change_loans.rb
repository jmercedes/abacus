class ChangeLoans < ActiveRecord::Migration
  def change
    remove_column :loans, :late_fee
    remove_column :loans, :capital_payment
  end
end