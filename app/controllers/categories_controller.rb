class CategoriesController < Carnival::BaseAdminController
  
  layout "carnival/admin"

  def permitted_params
    params.permit(category: [:name, :parent_category_id])
  end

end