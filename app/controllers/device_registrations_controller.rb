class DeviceRegistrationsController < ApplicationController
  respond_to :json

  def show
    device = DeviceRegistration.find_by(id: params[:id]) ||
      DeviceRegistration.find_by(platform_code: params[:id])
    if device
      respond_with device
    else
      head :not_found
    end
  end

  def create
    registration = DeviceRegistration.new
    registration.attributes = JSON.parse params[:device_registration]
    registration.save
    respond_with registration
  end
end
