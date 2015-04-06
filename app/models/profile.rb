class Profile < ActiveRecord::Base
  
  before_update :update_profile_progress, :if => Proc.new { |u| u.progress_status < 100 }
  
  belongs_to :user
  has_many :assets, dependent: :destroy
  has_many :references, dependent: :destroy
  has_one :guarantor, dependent: :destroy

  accepts_nested_attributes_for :assets, :allow_destroy => true
  accepts_nested_attributes_for :references, :allow_destroy => true
  accepts_nested_attributes_for :guarantor

  
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
  
  def name
    "#{names} #{lastnames}"
  end

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
  
end
