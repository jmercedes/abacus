class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      #User Personal information
      t.string :first_name
      t.string :second_name
      t.string :first_last_name
      t.string :second_last_name
      t.string :personal_identification_number
      t.string :social_status
      t.date :date_of_birth
      
      #Contact information
      t.string :residence_phone_number
      t.string :mobile_phone_number
      t.string :ofice_phone_number
      
      #Address information
      t.string :address
      t.string :address_2
      t.string :city
      t.string :sector
      t.string :province
      t.string :country
      
      #Education information
      t.string :profesion
      t.string :scholar_degree
      
      #Job Information
      t.string :job_position
      t.string :time_in_current_job
      t.string :monthly_income
      
      #Financial information
      t.string :other_income
      

      t.timestamps
    end
  end
end
