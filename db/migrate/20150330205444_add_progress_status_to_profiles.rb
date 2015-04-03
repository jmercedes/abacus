class AddProgressStatusToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :progress_status, :integer, :default => 0, :null => false
  end
end
