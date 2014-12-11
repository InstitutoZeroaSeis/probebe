class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :deny_admin_site_user_access_on_public_site
  before_filter :check_profile_status, except: [:new, :create, :edit, :update]

  def show
    @profile = current_profile
  end

  def new
    @profile = Profile.new
    @profile.cell_phones.build if @profile.cell_phones.empty?
    redirect_to edit_profile_path if current_profile
  end

  def create
    @profile = Profile.new
    @profile.user = current_user
    @profile.attributes = permitted_params
    if @profile.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
    @profile = current_profile
    @profile.cell_phones.build if @profile.cell_phones.empty?
    if current_profile.blank?
      redirect_to new_profile_path
    end
  end

  def update
    @profile = current_profile
    if @profile.update_attributes(permitted_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def save_profile
    redirect_to profile_path if @profile.save
  end

  def permitted_params
    profile_params = params[:profile]

    personal_attributes = [:first_name, :last_name, :gender, :birth_date, avatar_attributes: [:id, :photo]]
    mother_attributes = [children_attributes: [:id, :_destroy, :name, :birth_date, :gender]]
    contact_attributes = [:state, :city, :street, cell_phones_attributes: [:id, :area_code, :number, :_destroy]]

    profile_params ? profile_params.permit(personal_attributes + mother_attributes + contact_attributes) : {}
  end
end
