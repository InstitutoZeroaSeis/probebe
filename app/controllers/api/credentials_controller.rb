class Api::CredentialsController < ApplicationController
  include HeaderAuthenticationConcern

  def create
    user = User.find_by(email: params[:email])
    valid_hash = { valid: user.try(:valid_password?, params[:password]) || false }
    render json: valid_hash
  end
end
