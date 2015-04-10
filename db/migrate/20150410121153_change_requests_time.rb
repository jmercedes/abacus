class ChangeRequestsTime < ActiveRecord::Migration
  def change
    change_column :requests, :financing_rate, :decimal, :precision => 8, :scale => 2
    add_column :requests, :status, :string, default: 'pending'
    remove_column :requests, :is_approved
  end
end
