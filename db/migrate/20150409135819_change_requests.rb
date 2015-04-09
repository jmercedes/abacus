class ChangeRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :amount 

    add_column :requests, :amount, :decimal, :precision => 8, :scale => 2
    add_column :requests, :created_at, :datetime
    add_column :requests, :updated_at, :datetime
    add_column :requests, :is_approved, :boolean, :default => false

    add_index :requests, :user_id
  end
end
