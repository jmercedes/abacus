class Profile < ActiveRecord::Base
  
  belongs_to :user
  has_many :assets, dependent: :destroy
  has_many :references, dependent: :destroy
  has_one :guarantor
  
  validates :names,
            :lastnames,
            :date_of_birth,
            :nationality,
            :gender,
            :residence_status,
            :residence_status,
            :time_living_in_current_residence,
            :social_status,
            :address,
            :city,
            :sector,
            :province,
            #:country,
            presence: true
            
  validates :personal_identification_number, presence: true,
                                             length: { is: 11},
                                             numericality: /\A[+-]?\d+\Z/ 
  
  # validate  :age_cannot_be_less_than_eighteen
  
  #Validate phones
  # t.string   "residence_phone_number"
  # t.string   "mobile_phone_number"
  # t.string   "ofice_phone_number"
  
  
  #validate user is has 18 years old or older
  # def age_cannot_be_less_than_eighteen
  #   #age = Date.today - :date_of_birth
  #   #errors.add(:date_of_birth, "La edad debe ser mayor a los 18 años") if age < 18
  #   underage = (Date.today - 18.years) < date_of_birth
  #   errors.add(:date_of_birth, "La edad debe ser mayor a los 18 años") if underage 
  # end
  
  
  # validates :monthly_incomethly_income, numericality: true
  
  
end
