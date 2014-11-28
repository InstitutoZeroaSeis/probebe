class DeviceRegistrationsController < ApplicationController
  protect_from_forgery with: :null_session

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
    if User.find_by(email: params[:email]).try(:valid_password?, params[:password])
      registration = DeviceRegistration.new
      registration.attributes = permitted_params
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
