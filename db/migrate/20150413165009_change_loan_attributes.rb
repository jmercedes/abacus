class ChangeLoanAttributes < ActiveRecord::Migration
  def change
    change_table :loans do |t|
      t.remove :amount
      t.remove :status
      t.remove :rate
      t.remove :time_frame
      
      t.decimal :amount
      t.decimal :financing_rate
      t.integer :financing_time
      t.date :emision_date
      t.decimal :status
      t.integer :user_id
    end
  end
end