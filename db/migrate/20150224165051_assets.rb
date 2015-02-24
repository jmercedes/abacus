class Assets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :profile_id
      t.string  :name
      t.text    :description
      t.float   :commercial_value
      t.string  :ownership_status
      t.float   :amount_owned
      t.float   :amount_debt
    end
  end
end
