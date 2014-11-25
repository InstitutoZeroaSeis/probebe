class Admin::CategoriesController < Admin::AdminController

  load_and_authorize_resource

  layout "carnival/admin"

  def permitted_params
    params.permit(category: [:name, :parent_category_id])
  end

end
