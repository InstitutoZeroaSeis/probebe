class DeviceRegistrationsController < ApplicationController
  include HeaderAuthenticationConcern
  skip_before_filter :verify_authenticity_token

  def show
    registration = DeviceRegistration.find_by(id: params[:id]) ||
      DeviceRegistration.find_by(platform_code: params[:id])
    if registration
      render json: registration
    else
      head :not_found
    end
  end

  def create
    if user_signed_in?
      registration = DeviceRegistration.new
      registration.attributes = permitted_params
      registration.profile = current_profile
      registration.save
      render json: registration
    else
      head 403
    end
  end

  def permitted_params
    params.require(:device_registration).permit(:platform, :platform_code)
  end
end
