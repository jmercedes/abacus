class ChangeDeposits < ActiveRecord::Migration
  def change
    remove_column :deposits, :amount 
    remove_column :deposits, :account_id

    add_column :deposits, :amount, :decimal, :precision => 8, :scale => 2
    add_column :deposits, :account_id, :integer
    add_column :deposits, :created_at, :datetime
    add_column :deposits, :updated_at, :datetime

    add_index :deposits, :account_id
  end
end
