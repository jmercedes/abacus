class Profile < ActiveRecord::Base
  
  belongs_to :user
  
  #Stablish validation criteria
  validates :first_name,
            :first_last_name,
            :second_last_name,
            :date_of_birth,
            :social_status,
            :address,
            :city,
            :sector,
            :province,
            :country,
            :profession,
            :scholar_degree,
            :currently_working,
            :job_position,
            :time_in_current_job,
            :monthly_income,
            :other_income,
            presence: true
            
  validates :personal_identification_number, presence: true,
                                             length: { is: 11},
                                             numericality: { only_integer: true }
  
  validate  :age_cannot_be_less_than_eighteen
  
  #Validate phones
  # t.string   "residence_phone_number"
  # t.string   "mobile_phone_number"
  # t.string   "ofice_phone_number"
  
  
  #validate user is has 18 years old or older
  def age_cannot_be_less_than_eighteen
    #age = Date.today - :date_of_birth
    #errors.add(:date_of_birth, "La edad debe ser mayor a los 18 años") if age < 18
    underage = (Date.today - 18.years) < date_of_birth
    errors.add(:date_of_birth, "La edad debe ser mayor a los 18 años") if underage 
  end
  
  
  validates :monthly_incomethly_income, numericality: true
  
  
end
