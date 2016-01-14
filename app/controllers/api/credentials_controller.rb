class Api::CredentialsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.find_by(email: params[:email])

    if user.present?
      valid_hash = { valid: user.try(:valid_password?, params[:password]) || false }
      if valid_hash[:valid]
        valid_hash[:profile_type] = user.profile.profile_type
        valid_hash[:children] = user.profile.children
      end
    else
      valid_hash = { valid: false }
    end

    render json: valid_hash
  end
end
