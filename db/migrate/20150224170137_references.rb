class References < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :profile_id
      t.string  :name
      t.string  :last_name
      t.string  :residence_phone_numner
      t.string  :mobile_phone_number
      t.string  :linkage
    end
  end
end
