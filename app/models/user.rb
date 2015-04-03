class User < ActiveRecord::Base
  #rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
 has_one :profile
 after_create :create_profile
 
private

  def create_profile
   build_profile.save(validate: false)
 end 
end
