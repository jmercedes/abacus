class FixBirthDateColumns < ActiveRecord::Migration
  def change
    change_column :guarantors, :birth_date, 'date USING CAST(birth_date AS date)'
    change_column :profiles, :father_birthdate, 'date USING CAST(father_birthdate AS date)'
    change_column :profiles, :mother_birthdate, 'date USING CAST(mother_birthdate AS date)'
    change_column :profiles, :spouse_birthdate, 'date USING CAST(spouse_birthdate AS date)'
  end
end
