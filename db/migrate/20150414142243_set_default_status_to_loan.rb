class SetDefaultStatusToLoan < ActiveRecord::Migration
  def change
    change_column :loans, :status, :string, default: 'pending'
  end
end
