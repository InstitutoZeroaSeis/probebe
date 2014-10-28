class PersonalProfilesController < ApplicationController

  def show
    load_profile
  end

  def new
    load_profile
    render :new, locals: { profile: @profile }
  end

  def create
    build_profile
    @profile.profile = current_profile
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
    @profile = current_user.personal_profile || PersonalProfile.new
  end

  def build_profile
    @profile = params[:id] ? PersonalProfile.find(params[:id]) : PersonalProfile.new
    @profile.attributes = permitted_params
  end

  def save_profile
    if @profile.save
      redirect_to @profile
    end
  end

  def permitted_params
    profile_params = params[:personal_profile]
    profile_params ? profile_params.permit(:first_name, :last_name, :gender, :is_pregnant, :is_mother, avatar_attributes: [:id, :photo]) : {}
  end
end
