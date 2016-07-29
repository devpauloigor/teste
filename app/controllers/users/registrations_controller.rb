
class Users::RegistrationsController < Devise::RegistrationsController
 before_filter :configure_permitted_parameters
 before_filter :authenticate_user!


  protected

def resource_name
    :user
  end





  def configure_permitted_parameters
  
    devise_parameter_sanitizer.for(:sign_up).push(:email, :perfil, :nome)
    

 
  end

def registro
  @user = User.new


end
  

  #def user_params
   # params.require(:user).permit(:nome, :email, :perfil, :password, :password_confirmation)
   
   #end






# Virtual attribute for authenticating by either username or email
# This is in addition to a real persisted field like 'username'

  
end