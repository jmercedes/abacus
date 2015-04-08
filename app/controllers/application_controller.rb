class ApplicationController < ActionController::Base
  layout :layout_by_resource
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  protected
  
    def layout_by_resource
      if devise_controller?
        "devise"
      else
        "application"
      end
    end  

    def after_sign_in_path_for(resource)
      if resource.is_a?(User) 
        user_path(resource)
      else resource.is_a?(AdminUser)
        admin_dashboard_url
      end
    end
  
  
end
