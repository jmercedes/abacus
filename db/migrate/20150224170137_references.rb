class References < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :profile_id
      t.string  :name
      t.string  :last_name
      t.string  :personal_identification_number
      t.string  :residence_phone_number
      t.string  :mobile_phone_number
      t.string  :linkage
    end
  end
end
