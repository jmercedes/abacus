class Resquests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.float :amount
      t.integer :financing_time
      t.float :financing_rate
      t.integer :user_id
    end
  end
end
