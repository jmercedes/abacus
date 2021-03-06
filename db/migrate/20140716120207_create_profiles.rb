class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      #User Personal information
      t.string :names
      t.string :lastnames
      t.string :personal_identification_number
      t.string :nationality
      t.string :social_status
      t.string :gender
      t.date :date_of_birth      
      #Education information
      t.string :profession
      t.string :scholar_degree

      #Contact information
      t.string :residence_phone_number
      t.string :mobile_phone_number
      t.string :office_phone_number
      #Address information
      t.string :residence_status
      t.integer :time_living_in_current_residence
      t.string :address
      t.string :address_2
      t.string :address_reference
      t.string :city
      t.string :sector
      t.string :province
      t.string :country
      
      #Job Information
      t.string  :job_status 
      t.boolean :currently_working
      t.string  :business_name
      t.string  :business_social_reason
      t.string  :business_phone

      t.string :job_position
      t.string :time_in_current_job
      t.string :monthly_income
      t.string :prior_job
      #Financial information
      t.string :other_income
      
      #Job Information
      t.string  :job_status 
      t.boolean :currently_working
      t.string  :business_name
      t.string  :business_social_reason
      t.string  :business_phone

      t.string :job_position
      t.string :time_in_current_job
      t.string :monthly_income
      t.string :prior_job
      #Financial information
      t.string :other_income
      
      
      #Family information
      t.string :father_names
      t.string :father_lastnames
      t.string :father_personal_identification_number
      t.string :father_residence_phone_number
      t.string :father_mobile_phone_number
      t.string :father_birthdate
      t.string :father_address
      t.string :father_address_2
      t.string :father_city
      t.string :father_sector
      t.string :father_province
      t.string :father_country

      # 
      t.string :mother_names
      t.string :mother_lastnames
      t.string :father_personal_identification_number
      t.string :mother_residence_phone_number
      t.string :mother_mobile_phone_number
      t.string :mother_birthdate
      t.string :mother_address
      t.string :mother_address_2
      t.string :mother_city
      t.string :mother_sector
      t.string :mother_province
      t.string :mother_country

      
      t.string :spouse_names
      t.string :spouse_lastnames
      t.string :spouse_personal_identification_number
      t.string :spouse_mobile_phone_number
      t.string :spouse_birthdate
      
      #En la parte del conyugue , donde labora, tel., posición, ingreso, celulares, etc
      t.string :spouse_job_place
      t.string :spouse_job_position
      t.string :spouse_monthly_salary

      
      #Education information
      t.string :profession
      t.string :scholar_degree
      
      #Job Information
      t.string  :job_status 
      t.boolean :currently_working
      t.string  :business_name
      t.string  :business_social_reason
      t.string  :business_phone

      t.string :job_position
      t.string :time_in_current_job
      t.string :monthly_income
      t.string :prior_job
      #Financial information
      t.string :other_income

      t.timestamps
    end
  end
end