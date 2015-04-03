class Profile < ActiveRecord::Base
  
  
  before_update :update_profile_progress, :if => Proc.new { |u| u.progress_status < 100 }
  
  
  belongs_to :user
  has_many :assets, dependent: :destroy
  has_many :references, dependent: :destroy
  has_one :guarantor

  accepts_nested_attributes_for :assets

  
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
  private
  

  def update_profile_progress
      # All useful table fields
      profile_fields = Profile.column_names - ["id", "user_id"] 

      # iterator starts with 0
      progress = 0

      #loop every field and if it has data add 1 to iterator
      profile_fields.each do |field|
        progress += 1 unless field.blank?
      end

      # add assets to be part of profile completence
      profile_fields += ["assets"]

      # increment progress if it has any assets
      progress += 1 if self.assets.any?

      # calculate % of completence and store it in progress_status field
      self.progress_status = (progress * 100 / profile_fields.length).to_i
  end
  
  def self.completion_average
    profile_average = Profile.all(:select => :progress_status).collect(&:progress_status)
    progress_average = profile_average.sum.to_f / profile_average.size
  end
  
end
