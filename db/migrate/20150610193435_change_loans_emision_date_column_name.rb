class ChangeLoansEmisionDateColumnName < ActiveRecord::Migration
  def change
    rename_column :loans, :emision_date, :emission_date
  end
end
