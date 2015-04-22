class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :instantiate_profile
  layout 'blog'

  def update
    if @profile.update_attributes(permitted_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  protected

  def instantiate_profile
    @profile = ProfilePresenter.new(current_profile)
  end

  def permitted_params
    profile_params = params[:profile]

    personal_attributes = [:first_name, :last_name, :gender, :birth_date, :cell_phone_system, avatar_attributes: [:id, :photo]]
    mother_attributes = [children_attributes: [:id, :_destroy, :name, :birth_date, :gender, avatar_attributes: [:id, :photo]]]
    contact_attributes = [:state, :city, :street, :postal_code, :address_complement, :cell_phone, :home_phone, :business_phone]

    profile_params ? profile_params.permit(personal_attributes + mother_attributes + contact_attributes) : {}
  end
end
