class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource
  defaults resource_class: Category

  def permitted_params
    params.permit(category: [:name, :parent_category_id, :show_in_home,
                             :title, :subtitle, :text, :category_image,
                             :category_image_text, :position_in_home, :color])
  end
end
