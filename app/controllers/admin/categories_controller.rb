class Admin::CategoriesController < Carnival::BaseAdminController
  before_filter :authenticate_user!

  before_filter :deny_site_user_access_on_admin
  before_filter :deny_site_user_access_on_admin
  load_and_authorize_resource

  layout "carnival/admin"

  def permitted_params
    params.permit(category: [:name, :parent_category_id])
  end

end
