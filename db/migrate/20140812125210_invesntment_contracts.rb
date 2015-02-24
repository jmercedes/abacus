class InvesntmentContracts < ActiveRecord::Migration
  def change
    create_table :investment_contracts do |t|
      t.integer :user_id
      t.float :amount
      t.float :rate
      t.float :period_of_time
      t.string :status
      
      t.timestamps
    end
  end
end
