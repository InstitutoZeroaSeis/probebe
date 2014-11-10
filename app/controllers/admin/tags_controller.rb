class Admin::TagsController < Carnival::BaseAdminController

  before_filter :deny_site_user_access_on_admin
  before_filter :deny_site_user_access_on_admin
  load_and_authorize_resource class: 'Tag'

  private

  def permitted_params
    params.permit(tag: [:name])
  end

end
