class Api::PasswordsController < Devise::PasswordsController
  # include HeaderAuthenticationConcern
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  respond_to :json


end
