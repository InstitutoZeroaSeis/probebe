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
      registration = MessageDeliveries::DeviceRegistrations::
                     DeviceRegistrationCreator.create permitted_params, current_profile
      render json: registration
    end
  end

  def destroy
    MessageDeliveries::DeviceRegistrations::
    DeviceRegistrationDestroyer.destroy params[:platform_code]
    head 200
  end

  def permitted_params
    params.require(:device_registration).permit(:platform, :platform_code)
  end
end
