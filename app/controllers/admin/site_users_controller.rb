class Admin::SiteUsersController < Admin::AdminController
  layout 'carnival/admin'

  skip_before_action :deny_site_user_access_on_admin,
                     only: [:stop_impersonating]
  load_and_authorize_resource 'User', except: :stop_impersonating
  defaults resource_class: User

  def table_items
    User.site_user.includes(:profile)
  end

  def update
    @model = User.find params[:id]
    profile = @model.profile
    if profile.update_attributes permitted_params[:user][:profile_attributes]
      redirect_to action: :index
    else
      render action: 'edit'
    end
  end

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    flash[:success] = I18n.t(
      'success.controllers.admin.users.impersonate',
      user_name: current_user.email
    )
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to carnival_root_path
  end

  def authorize_receive_sms
    user = User.find(params[:id])
    user.profile.authorize_receive_sms!
    redirect_to action: :index
  end

  def unauthorize_receive_sms
    user = User.find(params[:id])
    user.profile.unauthorize_receive_sms!
    redirect_to action: :index
  end

  protected

  def permitted_params
    params.permit(user: [:email, :role, profile_attributes: [
                                          :name, :state, :city,
                                          :street, :cell_phone,
                                          children_attributes: [
                                            :id, :name, :birth_date
                                            ]
                                          ]
                  ])
  end
end
