class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :payments, :payment_day, :payment_date
  end
end
