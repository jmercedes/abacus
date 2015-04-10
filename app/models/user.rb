class User < ActiveRecord::Base
  include PermittableParams
  #rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :profile, dependent: :destroy

  has_many :requests

  after_create :create_blank_profile, if: Proc.new { |u| u.profile.nil? }

  accepts_nested_attributes_for :profile


  delegate :name, to: :profile, prefix: false
  delegate :assets, to: :profile, prefix: false
  delegate :references, to: :profile, prefix: false
  delegate :garantor, to: :profile, prefix: false
  delegate :editable?, to: :profile, prefix: false

  def self.prepare_new
    user = self.new
    user.build_profile
    user.profile.build_guarantor
    user.profile.assets.build
    user.profile.references.build
    user
  end

  private 

    def create_blank_profile
      self.build_profile
      self.profile.build_guarantor
      self.profile.assets.build
      self.profile.references.build
      self.save(validate: false)
    end

end
