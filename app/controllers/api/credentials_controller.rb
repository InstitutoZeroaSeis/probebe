class Api::CredentialsController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  def create
    user = User.find_by(email: params[:email])

    if user.present?
      valid_social_network = user.profile.social_network_id == params[:social_network_id]
      if valid_social_network
        valid_hash = { valid: valid_social_network }
      else
        valid_hash = { valid: user.try(:valid_password?, params[:password]) || false }
      end

      if valid_hash[:valid]
        valid_hash[:profile_type] = user.profile.profile_type
        valid_hash[:children] = user.profile.children
      end
    else
      valid_hash = { valid: false }
    end

    render json: valid_hash
  end

  def update_social_network_id
    user =  User.where(email: params[:email]).first
    if user.present?
      profile = Profile.find(user.profile.id)
      profile.social_network_id = params[:social_network_id]
      result = profile.save(:validate => false)
    end
    render json: {message: "ok"}
  end

end
