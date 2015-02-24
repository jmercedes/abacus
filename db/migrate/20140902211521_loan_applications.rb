class LoanApplications < ActiveRecord::Migration
  def change
    create_table :loan_applications do |t|
      t.float :amount
      t.float :rate
    end

  end
end
