class Guarantors < ActiveRecord::Migration
  def change
    create_table :guarantors do |t|
      t.integer :profile_id
      t.string :first_name
      t.string :second_name
      t.string :first_last_name
      t.string :second_last_name
      t.string :personal_identification_number
      t.string :birth_date
      t.string :gender
      
      t.string :nationality
      t.string :address
      t.string :city
      t.string :province
      t.string :zipcode

      t.string :residence_phone_number
      t.string :mobile_phone_number  
    end
  end
end
