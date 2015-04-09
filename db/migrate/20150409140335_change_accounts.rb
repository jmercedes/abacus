class ChangeAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :amount 
    remove_column :accounts, :user_id

    add_column :accounts, :amount, :decimal, :precision => 8, :scale => 2
    add_column :accounts, :company_id, :integer

    add_index :accounts, :company_id
  end
end
