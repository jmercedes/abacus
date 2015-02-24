class LoanTypes < ActiveRecord::Migration
  def change
    create_table :loan_types do |t|
      t.integer :loan_id
      t.string :name
    end
  end
end
