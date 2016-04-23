class Users::SessionsController < Devise::SessionsController

  def new
    super
  end

# def create
#   self.resource = warden.authenticate!(auth_options)
#     set_flash_message(:notice, :signed_in) if is_navigational_format?
#     sign_in(resource_name, resource)
#     if !session[:return_to].blank?
#       redirect_to session[:return_to]
#       session[:return_to] = nil
#     else
#       respond_with resource, :location => after_sign_in_path_for(resource)
#     end
# end

  def create
    self.resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if self.resource.valid_password?(params[:user][:password])
      sign_in(resource_name, resource)
      return render nothing: true
    end

    invalid_login_attempt
  end

  protected

  def invalid_login_attempt
    set_flash_message(:alert, :not_found_in_database)
    render json: flash[:alert], status: 401
  end

end
