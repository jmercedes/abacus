class FixBirthDateColumns < ActiveRecord::Migration
  def change
    change_column :guarantors, :birth_date, 'date USING CAST(birth_date AS date)'
    change_column :profiles, :father_birthdate, :date
    change_column :profiles, :mother_birthdate, :date
    change_column :profiles, :spouse_birthdate, :date
  end
end
