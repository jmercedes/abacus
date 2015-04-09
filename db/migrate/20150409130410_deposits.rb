class Deposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.string :account_id
      t.float :amount
    end
  end
end
