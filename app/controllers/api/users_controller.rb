class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  # before_action :configure_permitted_parameters
  respond_to :json
  layout "application", only: [:edit]

  def create
    render json: {message: "ok"}
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)
      .push(:source)
      .push(profile_attributes: [:name])
  end
end