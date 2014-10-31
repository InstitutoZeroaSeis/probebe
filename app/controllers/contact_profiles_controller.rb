class ContactProfilesController < ApplicationController

  skip_before_action :check_profile_status, only: [:edit, :create, :update]

  def show
    load_profile
  end

  def new
    build_profile
  end

  def create
    build_profile
    @profile.profile = current_user.profile
    save_profile or render :new
  end

  def edit
    build_profile
  end

  def update
    build_profile
    save_profile or render :edit
  end


  protected

  def load_profile
    @profile = current_profile.contact_profile
  end

  def build_profile
    @profile = load_profile || ContactProfile.new
    @profile.attributes = permitted_params
  end

  def save_profile
    if @profile.save
      redirect_to contact_profile_path
    end
  end
  
  def permitted_params
    profile_params = params[:contact_profile]
    profile_params ? profile_params.permit(:state, :city, :street, phones_attributes: [:id, :number, :phone_type,
                                           :area_code, :_destroy]) : {}
  end


end
