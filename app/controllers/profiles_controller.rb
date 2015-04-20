class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :deny_admin_site_user_access_on_public_site
  before_action :check_profile_status, except: [:new, :create, :edit, :update]
  before_action :instantiate_profile
  layout 'blog'

  def show
  end

  def new
    redirect_to edit_profile_path if current_profile
  end

  def create
    @profile.user = current_user
    @profile.attributes = permitted_params
    if @profile.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
    if current_profile.blank?
      redirect_to new_profile_path
    end
  end

  def update
    if @profile.update_attributes(permitted_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def save_profile
    redirect_to profile_path if @profile.save
  end

  protected

  def instantiate_profile
    @profile = ProfilePresenter.new(current_profile || Profile.new)
  end

  def permitted_params
    profile_params = params[:profile]

    personal_attributes = [:first_name, :last_name, :gender, :birth_date, :cell_phone_system, avatar_attributes: [:id, :photo]]
    mother_attributes = [children_attributes: [:id, :_destroy, :name, :birth_date, :gender, avatar_attributes: [:id, :photo]]]
    contact_attributes = [:state, :city, :street, :postal_code, :address_complement, :cell_phone, :home_phone, :business_phone]

    profile_params ? profile_params.permit(personal_attributes + mother_attributes + contact_attributes) : {}
  end
end
