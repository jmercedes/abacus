class FundAssignment < ActiveRecord::Migration
  def change
    create_table :fund_assignments do |t|
      t.float :amount
      t.float :rate
      t.float :period_of_time
    end
  end
end
