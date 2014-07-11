class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.float :amount

      t.timestamps
    end
  end
end
