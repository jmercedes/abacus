class Payments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.date :payment_day
      t.integer :loan_id 
    end
  end
end
