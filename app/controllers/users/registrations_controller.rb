class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  clear_respond_to
  respond_to :json

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)
      .push(profile_attributes: [:name])
  end
end
