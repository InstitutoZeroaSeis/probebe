class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  respond_to :json
  layout "application", only: [:edit]


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)
      .push(:source)
      .push(profile_attributes: [:name])
  end
end
