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
    save_user_role
    custom_params = permitted_params
    custom_params.delete(:user)
    @profile.update_attributes(custom_params)
    flash[:notice] = t('messages.updated')
    super
  end

  private

  def save_user_role
    @profile.user.role = params[:profile][:user][:role]
    @profile.user.save(validate: false)
  end

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
    user = [user: [:role]]
    personal_attributes = [:id, :user_id, :name, :gender, :birth_date, avatar_attributes: [:id, :photo, :_destroy]]
    contact_attributes = [:state, :city, :street, :cell_phone]

    profile_params ? profile_params.permit(personal_attributes + contact_attributes + user) : {}
  end

end
