class Api::CredentialsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.find_by(email: params[:email])

    if user.present?
      valid_hash = { valid: user.try(:valid_password?, params[:password]) || false }
      valid_hash[:profile_type] = user.profile.profile_type if valid_hash[:valid]
    else
      valid_hash = { valid: false }
    end

    render json: valid_hash
  end
end
