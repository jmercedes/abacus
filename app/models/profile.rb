class Profile < ActiveRecord::Base

  include PermittableParams
  
  before_save :update_profile_progress
  
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

  def editable?
    !(self.progress_status == 100)
  end

  private
  
    def update_profile_progress
      # All useful table fields
      profile_fields =  ProfileAttributes
      guarantor_fields = GuarantorAttributes
      assets_fields = AssetsAttributes - [:_destroy]
      references_fields = RefrencesAttributes - [:_destroy]

      progress = 0

      profile_fields.each do |field|
        progress += 1 if !self.send(field).nil? || self.send(field).present?
      end
      self.build_guarantor unless guarantor
      guarantor_fields.each do |field|
        progress += 1 if self.guarantor.send(field).present?
      end

      self.references.each do |ref|
        references_fields.each do |field|
          progress += 1 if ref.send(field).present?
        end
      end

      self.assets.each do |ass|
        assets_fields.each do |field|
          progress += 1 if ass.send(field).present?
        end
      end


      # calculate % of completence and store it in progress_status field
      total_fields = profile_fields.length + guarantor_fields.length + (self.assets.length * assets_fields.length) + (self.references.length * references_fields.length)
      self.progress_status = ((progress * 100) / total_fields ).to_i
    end
  
end
