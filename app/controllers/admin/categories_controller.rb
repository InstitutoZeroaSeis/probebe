class Admin::CategoriesController < Carnival::BaseAdminController

  before_filter :deny_site_user_access_on_admin
  before_filter :deny_site_user_access_on_admin

  layout "carnival/admin"

  def permitted_params
    params.permit(category: [:name, :parent_category_id])
  end

end
