class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :instantiate_profile

  def update
    if update_password_and_profile
      sign_in @user, bypass: true
      redirect_to root_path
    else
      @profile.errors.add(:base, user.errors.full_messages.first)
      render :edit
    end
  end

  protected

  def update_password_and_profile
    password = params[:profile][:user][:password] || ""
    @user.update_attributes password: password,
                            change_omniauth_password: true,
                            profile_attributes: permitted_params.merge(id: @profile.id)
  end

  def instantiate_profile
    @profile = ProfilePresenter.new(current_profile)
    @user = @profile.user
  end

  def permitted_params
    profile_params = params[:profile]
    personal_attributes = [:name, :gender, :birth_date, :cell_phone_system, avatar_attributes: [:id, :photo]]
    mother_attributes = [children_attributes: [:id, :_destroy, :name, :born, :birth_date, :gender, avatar_attributes: [:id, :photo]]]
    contact_attributes = [:state, :city, :street, :postal_code, :address_complement, :cell_phone]

    profile_params ? profile_params.permit(personal_attributes + mother_attributes + contact_attributes) : {}
  end
end
