class Admin::ProfilesController < Admin::AdminController
  defaults :resource_class => Profile
  load_and_authorize_resource class: 'Profile'

  skip_before_action :deny_site_user_access_on_admin

  def build_resource
    if action_name == "new"
      user = find_user(params[:id])
      assign_user_to_profile(user)
    elsif action_name == "create"
      assign_attributes_to_profile
    else
      super
    end
  end

  def update
    @profile.update_attributes(permitted_params)
    flash[:notice] = t('messages.updated')
    update!
  end

  private

  def find_user(id)
    User.find(id)
  end

  def assign_user_to_profile(user)
    @profile = Profile.new(user: user)
  end

  def assign_attributes_to_profile
    @profile = Profile.new(permitted_params)
  end

  def permitted_params
    profile_params = params[:profile]

    personal_attributes = [:id, :user_id, :first_name, :last_name, :gender, :birth_date, avatar_attributes: [:id, :photo, :_destroy]]
    contact_attributes = [:state, :city, :street, cell_phones_attributes: [:id, :area_code, :number, :_destroy]]

    profile_params ? profile_params.permit(personal_attributes + contact_attributes) : {}
  end

end
