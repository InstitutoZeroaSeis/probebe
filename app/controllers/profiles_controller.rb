class ProfilesController < ApplicationController
  skip_before_filter :check_profile_status, only: [:edit, :update]

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
    save_profile or render :edit
  end

  protected

  def load_profile
    @profile = current_profile
  end

  def build_profile
    @profile = load_profile || Profile.new
    @profile.attributes = permitted_params
  end

  def save_profile
    redirect_to profile_path if @profile.save
  end

  def permitted_params
    profile_params = params[:profile]

    personal_attributes = [:first_name, :last_name, :gender, :is_pregnant, :is_mother, avatar_attributes: [:id, :photo]]
    mother_attributes = [:is_mother, :is_pregnant, children_attributes: [:id, :_destroy, :name, :birth_date, :gender, :born, :pregnancy_start_date]]
    contact_attributes = [:state, :city, :street, phones_attributes: [:id, :number, :phone_type, :area_code, :_destroy]]

    profile_params ? profile_params.permit(personal_attributes + mother_attributes + contact_attributes) : {}
  end
end
