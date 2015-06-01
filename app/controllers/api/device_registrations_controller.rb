class Api::DeviceRegistrationsController < ApplicationController
  include HeaderAuthenticationConcern

  def show
    registration = MessageDeliveries::DeviceRegistration.find_by(platform_code: params[:platform_code])
    if registration
      render json: registration
    else
      head :not_found
    end
  end

  def create
    registration = MessageDeliveries::DeviceRegistration.find_by(
      platform_code: permitted_params[:platform_code],
      platform: permitted_params[:platform]
    )
    if registration
      head 304
    else
      registration = MessageDeliveries::DeviceRegistration.new
      registration.assign_attributes permitted_params
      registration.profile = current_profile
      registration.save
      render json: registration
    end
  end

  def destroy
    registration = MessageDeliveries::DeviceRegistration.find_by(platform_code: params[:platform_code])
    registration.destroy
    head 200
  end

  def permitted_params
    params.require(:device_registration).permit(:platform, :platform_code)
  end
end
