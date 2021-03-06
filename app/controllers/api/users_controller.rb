class Api::UsersController < Devise::RegistrationsController
  # include HeaderAuthenticationConcern
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters
  respond_to :json
  layout "application", only: [:edit]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)
      .push(:source)
      .push(profile_attributes: [:name, :social_network_id])
  end
end
