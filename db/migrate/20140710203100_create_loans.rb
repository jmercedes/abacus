class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.float :amount
      t.string :status
      t.float :rate
      t.integer :time_frame

      t.timestamps
    end
  end
end
