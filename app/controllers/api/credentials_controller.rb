class Api::CredentialsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.find_by(email: params[:email])
    valid_hash = { valid: user.try(:valid_password?, params[:password]) || false }
    render json: valid_hash
  end

end
