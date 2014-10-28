class MotherProfilesController < ApplicationController

  def show
    load_profile
  end

  def new
    build_profile
  end

  def create
    build_profile
    @mother_profile.profile = current_profile
    save_profile or render :new
  end

  def edit
    build_profile
  end

  def update
    build_profile
    save_profile or render :edit
  end

  def permitted_params
    mother_profile = params[:mother_profile]
    mother_profile ? mother_profile.permit(:is_mother, :is_pregnant, children_attributes: [:id, :_destroy, :name, :birth_date, :gender, :born, :expected_birth_week, :expected_birth_year]) : {}
  end

  protected

  def load_profile
    @mother_profile = current_profile.mother_profile
  end

  def build_profile
    @mother_profile = load_profile || MotherProfile.new
    @mother_profile.attributes = permitted_params
  end

  def save_profile
    redirect_to mother_profile_path if @mother_profile.save
  end

end
