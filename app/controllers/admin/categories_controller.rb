class Admin::CategoriesController < Admin::AdminController

  load_and_authorize_resource
  defaults resource_class: Category

  def permitted_params
    params.permit(category: [:name, :parent_category_id])
  end

end
