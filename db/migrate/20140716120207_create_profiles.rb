class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      #User Personal information
      t.string :first_name
      t.string :second_name
      t.string :first_last_name
      t.string :second_last_name
      t.string :personal_identification_number
      t.string :nationality
      t.string :social_status
      t.string :gender
      t.date :date_of_birth      
      
      #Family information
      t.string :father_first_name
      t.string :father_second_name
      t.string :father_first_lastname
      t.string :father_second_lastname
      # 
      t.string :mother_first_name
      t.string :mother_second_name
      t.string :mother_first_lastname
      t.string :mother_second_lastname
      
      t.string :spouse_first_name
      t.string :spouse_second_name
      t.string :spouse_first_lastname
      t.string :spouse_second_lastname
      t.string :spouse_personal_identification_number
      t.string :spouse_mobile_phone_number
      t.string :spouse_date_of_birth

      
      #Contact information
      t.string :residence_phone_number
      t.string :mobile_phone_number
      t.string :office_phone_number
      
      #Address information
      t.string :residence_status
      t.integer :time_living_in_current_residence
      t.string :address
      t.string :address_2
      t.string :city
      t.string :sector
      t.string :province
      t.string :country
      
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