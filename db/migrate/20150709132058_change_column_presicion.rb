class ChangeColumnPresicion < ActiveRecord::Migration
  def change
    change_column :accounts, :amount, :decimal, :precision => 10, :scale => 2
    change_column :payments, :amount, :decimal, :precision => 10, :scale => 2
    change_column :deposits, :amount, :decimal, :precision => 10, :scale => 2
    change_column :loans, :amount, :decimal, :precision => 10, :scale => 2    
  end
end
