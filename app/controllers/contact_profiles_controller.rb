class ContactProfilesController < ApplicationController

  def show
    load_profile
  end

  def new
    load_profile
    render :new, locals: { profile: @profile }
  end

  def create
    build_profile
    @profile.profile = current_user.profile
    save_profile or render :new, locals: { profile: @profile }
  end

  def edit
    load_profile
    render :edit, locals: { profile: @profile }
  end

  def update
    build_profile
    save_profile or render :edit, locals: { profile: @profile }
  end


  protected

  def load_profile
    @profile = current_profile.contact_profile || ContactProfile.new
  end

  def build_profile
    @profile = params[:id] ? ContactProfile.find(params[:id]) : ContactProfile.new
    @profile.attributes = permitted_params
  end

  def save_profile
    if @profile.save
      redirect_to @profile
    end
  end
  
  def permitted_params
    profile_params = params[:contact_profile]
    profile_params ? profile_params.permit(:state, :city, :street, phones_attributes: [:id, :number, :phone_type,
                                           :area_code, :_destroy]) : {}
  end


end