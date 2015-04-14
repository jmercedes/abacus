class ChangeLoanStatusDataType < ActiveRecord::Migration
  def change
    change_table :loans do |t|
      t.remove :status
      t.string :status
    end
  end
end
