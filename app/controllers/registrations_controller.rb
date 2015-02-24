class RegistrationsController < Devise::RegistrationsController
    
  def awaiting_confirmation
  end
  

  protected
  
  def after_sign_up_path_for(resource)
    new_profile_path
  end


  def after_inactive_sign_up_path_for(resource)
    registrations_awaiting_confirmation_path
  end

end
