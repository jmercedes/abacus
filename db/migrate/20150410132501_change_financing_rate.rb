class ChangeFinancingRate < ActiveRecord::Migration
  def change
    change_column :requests, :financing_rate, :integer, default: 0
  end
end
