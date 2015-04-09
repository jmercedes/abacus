class Accounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :number
      t.text :description
      t.float :amount
      t.integer :user_id
    end
  end
end
